//
//  BumperPage.swift
//  SuperAwesome
//
//  Created by Gunhan Sancar on 25/08/2020.
//

import UIKit

@objc(SABumperPage)
public class BumperPage: UIViewController, Injectable {
    private static let CounterMaxInSeconds = 3
    private let accessibilityPrefix = "SuperAwesome.Bumper."

    // Dependencies
    private lazy var imageProvider: ImageProviderType = dependencies.resolve()
    private lazy var stringProvider: StringProviderType = dependencies.resolve()

    private var onComplete: VoidBlock?

    private var bgView: UIImageView?
    private var logo: UIImageView?
    private var poweredBy: UIImageView?
    private var bigLabel: UILabel?
    private var smallLabel: UILabel?

    private var timer: Timer?
    private var counter = 0

    private static var overridenLogo: UIImage?
    private static var overridenName: String?

    public override func viewDidLoad() {
        super.viewDidLoad()
        setTimerVars()
        createBackground()
        createSupportPanel()
        createLogo()
        createPoweredByLogo()
        createSmallLabel()
        createBigLabel()
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        createTimer()
    }

    public override func viewDidDisappear(_ animated: Bool) {

        timer?.invalidate()
        timer = nil

        if let presenter = presentingViewController {
            presenter.dismiss(animated: animated)
        } else {
            dismiss(animated: animated)
        }

        super.viewDidDisappear(animated)
    }

    private func setTimerVars() {
        counter = BumperPage.CounterMaxInSeconds
    }

    private func createTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(timerFunction),
                                     userInfo: nil,
                                     repeats: true)
    }

    private func createBackground() {
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        view.accessibilityIdentifier = "\(accessibilityPrefix)Screen"
    }

    private func createSupportPanel() {
        let screen = UIScreen.main.bounds.size
        let padding: CGFloat = 20
        let size = CGFloat(min(screen.width, screen.height)) - 2 * padding

        let imageView = UIImageView()
        imageView.image = imageProvider.bumperBackgroundImage
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = false
        imageView.layer.shadowRadius = 5
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 0.25
        imageView.layer.cornerRadius = 5
        imageView.layer.shadowOffset = CGSize(width: 0, height: 0)
        imageView.backgroundColor = UIColor.white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.accessibilityIdentifier = "\(accessibilityPrefix)ImageViews.Background"
        view.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: size),
            imageView.heightAnchor.constraint(equalToConstant: size),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0)
        ])

        bgView = imageView
    }

    private func createLogo() {
        guard let overriddenLogo = BumperPage.overridenLogo, let panel = bgView else { return }

        let screen = UIScreen.main.bounds.size
        let padding: CGFloat = 20
        let size = CGFloat(min(screen.width, screen.height)) - 2 * padding

        let imageView = UIImageView()
        imageView.image = overriddenLogo
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.accessibilityIdentifier = "\(accessibilityPrefix)ImageViews.AppLogo"

        panel.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: size),
            imageView.heightAnchor.constraint(equalToConstant: 50.0),
            imageView.centerXAnchor.constraint(equalTo: panel.centerXAnchor, constant: 0),
            imageView.topAnchor.constraint(equalTo: panel.topAnchor, constant: 0)
        ])

        logo = imageView
    }

    private func createPoweredByLogo() {
        guard let panel = bgView else { return }

        let imageView = UIImageView()
        imageView.image = imageProvider.bumperPoweredByImage
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.accessibilityIdentifier = "\(accessibilityPrefix)ImageViews.PoweredByLogo"

        panel.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 80.0),
            imageView.heightAnchor.constraint(equalToConstant: 30.0),
            imageView.centerXAnchor.constraint(equalTo: panel.centerXAnchor, constant: 0),
            imageView.bottomAnchor.constraint(equalTo: panel.bottomAnchor, constant: 0)
        ])

        poweredBy = imageView
    }

    private func createSmallLabel() {
        guard let panel = bgView, let poweredBy = poweredBy else { return }

        let label = UILabel()
        label.text = stringProvider.bumperPageInfo(counter: counter)
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.accessibilityIdentifier = "\(accessibilityPrefix)Labels.Small"
        panel.addSubview(label)

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: panel.leadingAnchor, constant: 12.0),
            label.trailingAnchor.constraint(equalTo: panel.trailingAnchor, constant: -12.0),
            label.bottomAnchor.constraint(equalTo: poweredBy.topAnchor, constant: -6.0)
        ])

        smallLabel = label
    }

    private func createBigLabel() {
        guard let panel = bgView, let smallLabel = smallLabel else { return }

        let label = UILabel()
        bigLabel = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = stringProvider.bumperPageLeaving(appName: BumperPage.overridenName)
        label.accessibilityIdentifier = "\(accessibilityPrefix)Labels.Big"
        panel.addSubview(label)

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: panel.leadingAnchor, constant: 12.0),
            label.trailingAnchor.constraint(equalTo: panel.trailingAnchor, constant: -12.0),
            label.bottomAnchor.constraint(equalTo: smallLabel.topAnchor, constant: -6.0)
        ])

        bigLabel = label
    }

    @objc
    private func timerFunction() {
        if counter > 0 {
            counter -= 1
            smallLabel?.text = stringProvider.bumperPageInfo(counter: counter)
        } else {
            timer?.invalidate()
            timer = nil

            if let presenter = presentingViewController {
                presenter.dismiss(animated: true) { [weak self] in
                    self?.onComplete?()
                }
            } else {
                dismiss(animated: true) { [weak self] in
                    self?.onComplete?()
                }
            }
        }
    }

    func play(_ onComplete: VoidBlock?) {
        self.onComplete = onComplete
        modalPresentationStyle = .overCurrentContext
        modalTransitionStyle = .crossDissolve
        UIApplication.shared.keyWindow?.rootViewController?.getTopMostViewController().present(self, animated: true)
    }

    /// Overrides the logo on the bumper dialog
    @objc
    public class func overrideLogo(_ image: UIImage?) {
        overridenLogo = image
    }

    /// Overrides the name on the bumper dialog
    @objc
    public class func overrideName(_ name: String?) {
        overridenName = name
    }
}
