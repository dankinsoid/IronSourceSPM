//
//  InterstitialAdController.swift
//  SuperAwesome
//
//  Created by Gunhan Sancar on 04/09/2020.
//

import UIKit

class InterstitialAdViewController: UIViewController, Injectable {

    private let accessibilityPrefix = "SuperAwesome.Interstital."
    private let adResponse: AdResponse
    private let parentGateEnabled: Bool
    private let bumperPageEnabled: Bool
    private let closeButtonState: CloseButtonState
    private let closeButtonDelay: TimeInterval
    private let testingEnabled: Bool
    private let orientation: Orientation
    private let closeButtonSize: CGFloat = 40.0

    private var bannerView: BannerView?
    private var closeButton: UIButton?
    private var renderTimeTimer: PerformanceTimer?
    private var failSafeTimer: CountdownTimerType?
    private var closeButtonDelayTimer: CountdownTimerType?

    private lazy var imageProvider: ImageProviderType = dependencies.resolve()
    private lazy var orientationProvider: OrientationProviderType = dependencies.resolve()
    private lazy var controller: AdControllerType = dependencies.resolve()

    // swiftlint:disable weak_delegate
    private var delegate: AdEventCallback?
    // swiftlint:enable weak_delegate

    init(adResponse: AdResponse,
         parentGateEnabled: Bool,
         bumperPageEnabled: Bool,
         closeButtonState: CloseButtonState,
         closeButtonDelay: TimeInterval,
         testingEnabled: Bool,
         orientation: Orientation,
         delegate: AdEventCallback?) {
        self.adResponse = adResponse
        self.parentGateEnabled = parentGateEnabled
        self.bumperPageEnabled = bumperPageEnabled
        self.closeButtonState = closeButtonState
        self.closeButtonDelay = closeButtonDelay
        self.testingEnabled = testingEnabled
        self.orientation = orientation
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundGray
        view.accessibilityIdentifier = "\(accessibilityPrefix)Screen"

        // register notification for foreground
        // swiftlint:disable discarded_notification_center_observer
        NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification,
                                               object: nil,
                                               queue: .main) { [weak self] notification in
            self?.willEnterForeground(notification)
        }

        // register notification for background
        NotificationCenter.default.addObserver(forName: UIApplication.didEnterBackgroundNotification,
                                               object: nil,
                                               queue: .main) { [weak self] _ in
            self?.didEnterBackground()
        }
        // swiftlint:enable discarded_notification_center_observer

        failSafeTimer = CountdownTimer() { [weak self] in
            self?.closeButton?.isHidden = false
            self?.controller.adEnded()
            self?.controller.trackCloseButtonFallbackShown()
        }
        failSafeTimer?.start()

        configureBannerView()
        configureCloseButton()
        trackRenderTimeStart()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bannerView?.play()
    }

    override var shouldAutorotate: Bool { true }

    override var prefersStatusBarHidden: Bool { true }

    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation { .fade }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        orientationProvider.findSupportedOrientations(orientation, super.supportedInterfaceOrientations)
    }

    // MARK: Background / Foreground handlers

    @objc
    func willEnterForeground(_ notification: Notification) {
        failSafeTimer?.start()
        closeButtonDelayTimer?.start()
    }

    private func didEnterBackground() {
        failSafeTimer?.pause()
        closeButtonDelayTimer?.pause()
    }

    /// Method that is called to close the ad
    func close() {
        bannerView?.close()
        bannerView = nil
        dismiss(animated: true)
    }

    private func configureBannerView() {
        let bannerView = BannerView()
        
        let eventCallback: AdEventCallback = { [weak self] placementId, event in
            self?.delegate?(placementId, event)
            if event == .adShown {
                self?.failSafeTimer?.stop()
                self?.trackRenderTimeEnd()
                self?.closeButtonDelayTimer?.start()
            }
        }
        
        bannerView.configure(adResponse: adResponse, delegate: eventCallback) { [weak self] in
            guard self?.closeButtonState != .custom else { return }
            self?.closeButton?.isHidden = false
        }
        bannerView.setTestMode(testingEnabled)
        bannerView.setBumperPage(bumperPageEnabled)
        bannerView.setParentalGate(parentGateEnabled)
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        bannerView.accessibilityIdentifier = "\(accessibilityPrefix)Banner"
        view.addSubview(bannerView)

        NSLayoutConstraint.activate([
            bannerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0),
            bannerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0),
            bannerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0),
            bannerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0)
        ])

        self.bannerView = bannerView
    }

    private func configureCloseButton() {
        let button = UIButton()
        button.isHidden = closeButtonState != .visibleImmediately
        button.setTitle("", for: .normal)
        button.setImage(imageProvider.closeImage, for: .normal)
        button.addTarget(self, action: #selector(onCloseClicked), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.accessibilityIdentifier = "\(accessibilityPrefix)Buttons.Close"

        view.addSubview(button)

        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: closeButtonSize),
            button.heightAnchor.constraint(equalToConstant: closeButtonSize),
            button.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor, constant: 0.0),
            button.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: 0.0)
        ])

        self.closeButton = button

        if closeButtonState == .custom {
            closeButtonDelayTimer = CountdownTimer(timeInterval: closeButtonDelay) { [weak self] in
                self?.closeButton?.isHidden = false
            }
        }
    }

    @objc private func onCloseClicked() {
        close()
    }
    
    private func isRichMedia() -> Bool {
        return adResponse.advert.creative.format == .richMedia || adResponse.advert.creative.format == .tag
    }
    
    private func trackRenderTimeStart() {
        guard renderTimeTimer == nil, isRichMedia() else { return }
        renderTimeTimer = PerformanceTimer(timeProvider: dependencies.resolve() as TimeProviderType)
    }
    
    private func trackRenderTimeEnd() {
        guard let renderTimeTimer = renderTimeTimer, isRichMedia() else { return }
        controller.trackRenderTime(renderTime: renderTimeTimer.calculate())
        self.renderTimeTimer = nil
    }

    deinit {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIApplication.willEnterForegroundNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIApplication.didEnterBackgroundNotification,
                                                  object: nil)
        delegate = nil
        renderTimeTimer = nil
        failSafeTimer?.stop()
        failSafeTimer = nil
        closeButtonDelayTimer?.stop()
        closeButtonDelayTimer = nil
    }
}
