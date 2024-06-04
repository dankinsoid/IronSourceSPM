//
//  SAChromeControl.swift
//  SuperAwesome
//
//  Created by Gabriel Coman on 17/12/2018.
//

import UIKit

@objc(SAAdSocialVideoPlayerControlsView)
public class AdSocialVideoPlayerControlsView: UIView, VideoPlayerControlsView {

    private let accessibilityPrefix = "SuperAwesome.Video.Controls."
    private let chronoSize = CGSize(width: 50.0, height: 20.0)
    private let clickerSize = CGSize(width: 100.0, height: 20.0)
    private let chronoPadding: CGFloat = 5.0
    private let clickerPadding: CGFloat = 8.0
    private let blackMaskHeightMultiplier: CGFloat = 0.2

    private var blackMask: BlackMask!
    private var chrono: Chronograph!
    private var clicker: URLClicker!
    private var padlock: Padlock!
    private var closeButton: CloseButton!
    private var volumeButton: VolumeButton!
    private var smallClicker: Bool = false
    private var safeLogoVisible: Bool = true
    private var didSetupConstraints: Bool = false

    private var padlockAction: (() -> Void)?
    private var closeAction: (() -> Void)?
    private var clickAction: (() -> Void)?
    private var volumeAction: (() -> Void)?

    @objc(initWithSmallClick:andShowSafeAdLogo:)
    init(smallClick: Bool, showSafeAdLogo: Bool) {
        self.smallClicker = smallClick
        self.safeLogoVisible = showSafeAdLogo
        super.init(frame: .zero)
        initSubViews(smallClick, showSafeAdLogo)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubViews(false, true)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubViews(false, true)
    }

    public override func updateConstraints() {
        if !didSetupConstraints {
            didSetupConstraints = true

            blackMask.translatesAutoresizingMaskIntoConstraints = false
            blackMask.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            blackMask.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            blackMask.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            blackMask.heightAnchor.constraint(equalTo: heightAnchor,
                                              multiplier: blackMaskHeightMultiplier).isActive = true
            chrono.translatesAutoresizingMaskIntoConstraints = false
            if #available(iOS 11.0, *) {
                chrono.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor,
                                                constant: chronoPadding).isActive = true
                chrono.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor,
                                               constant: -chronoPadding).isActive = true
            } else {
                chrono.leadingAnchor.constraint(equalTo: leadingAnchor, constant: chronoPadding).isActive = true
                chrono.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -chronoPadding).isActive = true
            }
            chrono.widthAnchor.constraint(equalToConstant: chronoSize.width).isActive = true
            chrono.heightAnchor.constraint(equalToConstant: chronoSize.height).isActive = true

            if !smallClicker {
                clicker.topAnchor.constraint(equalTo: topAnchor, constant: clickerPadding).isActive = true
                clicker.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
                clicker.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
                clicker.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -clickerPadding).isActive = true
            } else {
                clicker.leadingAnchor.constraint(equalTo: chrono.trailingAnchor,
                                                 constant: clickerPadding).isActive = true
                clicker.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
                clicker.widthAnchor.constraint(equalToConstant: clickerSize.width).isActive = true
                clicker.heightAnchor.constraint(equalToConstant: clickerSize.height).isActive = true
            }

            if safeLogoVisible {
                padlock = Padlock()
                padlock.accessibilityIdentifier = "\(accessibilityPrefix)Buttons.Padlock"
                padlock.addTarget(self, action: #selector(didTapOnPadlock), for: .touchUpInside)
                addSubview(padlock)
                padlock.translatesAutoresizingMaskIntoConstraints = false

                if #available(iOS 11.0, *) {
                    padlock.topAnchor.constraint(equalToSystemSpacingBelow: safeAreaLayoutGuide.topAnchor,
                                                 multiplier: 1.0).isActive = true
                    padlock.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor,
                                                     constant: ImageProvider.safeAdInsets.left).isActive = true
                } else {
                    padlock.topAnchor.constraint(equalTo: topAnchor,
                                                 constant: ImageProvider.safeAdInsets.top).isActive = true
                    padlock.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                     constant: ImageProvider.safeAdInsets.left).isActive = true
                }
                padlock.widthAnchor.constraint(equalToConstant: ImageProvider.safeAdSize.width).isActive = true
                padlock.heightAnchor.constraint(equalToConstant: ImageProvider.safeAdSize.height).isActive = true
            }
            closeButton.bind(toTopRightOf: self)
            volumeButton.bind(toBottomRightOf: self)
        }

        super.updateConstraints()
    }

    private func initSubViews(_ smallClick: Bool, _ showSafeAdLogo: Bool) {

        accessibilityIdentifier = "\(accessibilityPrefix)Screen"

        blackMask = BlackMask()
        blackMask.accessibilityIdentifier = "\(accessibilityPrefix)Views.BlackMask"
        addSubview(blackMask)

        chrono = Chronograph()
        chrono.accessibilityIdentifier = "\(accessibilityPrefix)Views.Chronograph"
        addSubview(chrono)

        clicker = URLClicker(smallClick: smallClick)
        clicker.accessibilityIdentifier = "\(accessibilityPrefix)Buttons.Clicker"
        clicker.translatesAutoresizingMaskIntoConstraints = false
        clicker.addTarget(self, action: #selector(didTapOnUrl), for: .touchUpInside)
        addSubview(clicker)

        closeButton = CloseButton()
        closeButton.isHidden = true
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        closeButton.accessibilityIdentifier = "\(accessibilityPrefix)Buttons.Close"
        addSubview(closeButton)

        volumeButton = VolumeButton()
        volumeButton.isHidden = true
        volumeButton.addTarget(self, action: #selector(onVolumeTapped), for: .touchUpInside)
        volumeButton.accessibilityIdentifier = "\(accessibilityPrefix)Buttons.Volume"
        addSubview(volumeButton)
    }

    ////////////////////////////////////////////////////////////////////////////
    // custom methods
    ////////////////////////////////////////////////////////////////////////////

    @objc(makeCloseButtonVisible)
    public func makeCloseButtonVisible() {
        closeButton.isHidden = false
    }

    @objc(makeVolumeButtonVisible)
    public func makeVolumeButtonVisible() {
        volumeButton.isHidden = false
    }

    public func setPadlockAction(action: @escaping () -> Void) {
        padlockAction = action
    }

    public func setClickAction(action: @escaping () -> Void) {
        clickAction = action
    }

    public func setCloseAction(action: @escaping () -> Void) {
        closeAction = action
    }

    public func setVolumeAction(action: @escaping () -> Void) {
        volumeAction = action
    }

    ////////////////////////////////////////////////////////////////////////////
    // Private tap functions
    ////////////////////////////////////////////////////////////////////////////

    @objc
    private func didTapOnPadlock() {
        padlockAction?()
    }

    @objc
    private func didTapOnUrl() {
        clickAction?()
    }

    @objc
    func close() {
        closeAction?()
    }

    @objc
    func onVolumeTapped() {
        volumeAction?()
    }

    @objc
    func setMuted(_ muted: Bool) {
        volumeButton.setMuted(muted)
        volumeButton.accessibilityIdentifier = "\(accessibilityPrefix)Buttons.Volume.\(muted ? "Off" : "On")"
    }

    ////////////////////////////////////////////////////////////////////////////
    // ChromeControl
    ////////////////////////////////////////////////////////////////////////////

    public func setPlaying() { /* N/A */ }

    public func setPaused() { /* N/A */ }

    public func setCompleted() { /* N/A */ }

    public func setError(error: Error) { /* N/A */ }

    public func setTime(time: Int, duration: Int) {
        let remaining = duration - time
        chrono.setTime(remaining: remaining)
    }

    public func isPlaying() -> Bool {
        return true
    }

    public func show() { /* N/A */ }

    public func hide() { /* N/A */ }

    public func setMinimised() { /* N/A */ }

    public func setMaximised() { /* N/A */ }

    public func isMaximised() -> Bool {
        return bounds == UIApplication.shared.keyWindow?.bounds
    }

    @objc(setDelegate:)
    public func set(delegate: VideoPlayerControlsViewDelegate) { /* N/A */ }

    @objc(setListener:)
    public func set(controlsViewListener: VideoPlayerControlsViewDelegate) { /* N/A */ }
}
