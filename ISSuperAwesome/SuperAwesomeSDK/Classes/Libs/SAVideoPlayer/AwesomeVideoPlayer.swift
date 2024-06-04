//
//  AwesomeVideoPlayer.swift
//  Pods
//
//  Created by Gabriel Coman on 10/12/2018.
//

import AVFoundation
import AVKit
import Foundation
import UIKit

@objc(SAAwesomeVideoPlayer)
public class AwesomeVideoPlayer: UIView, VideoPlayer {

    internal static let animationDuration = 0.3

    private var playerLayer: AVPlayerLayer?
    private var didSetUpConstraints: Bool = false

    private weak var controller: VideoPlayerControls?
    private weak var controllerView: VideoPlayerControlsView?

    internal var isFullscreen: Bool = false

    public weak var delegate: VideoPlayerDelegate?

    private weak var previousParent: UIView?

    ////////////////////////////////////////////////////////////////////////////
    // Different setters and getters
    ////////////////////////////////////////////////////////////////////////////

    @objc(setControls:)
    public func setControls(controller: VideoPlayerControls) {
        self.controller = controller
        self.controller?.set(delegate: self)
    }

    @objc(setConstrolsView:insets:)
    public func setControlsView(controllerView: VideoPlayerControlsView, insets: UIEdgeInsets = .zero) {
        (self.controllerView as? UIView)?.removeFromSuperview()
        self.controllerView = controllerView
        self.controllerView?.set(delegate: self)
        guard let chrome = self.controllerView as? UIView else { return }
        addSubview(chrome)
        chrome.bind(toTheEdgesOf: self, insets: insets)
    }

    public func destroy() {
        controller?.reset()
        controller = nil
        (controllerView as? UIView)?.removeFromSuperview()
        controllerView = nil
        delegate = nil
        playerLayer?.removeFromSuperlayer()
        playerLayer = nil
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        playerLayer?.frame = CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height)
    }

    @objc(player)
    func getPlayer() -> AVPlayer? {
        guard let control = controller as? AVPlayer else {
            return nil
        }
        return control
    }

    @objc(playerLayer)
    func getLayer() -> AVPlayerLayer? {
        return playerLayer
    }

    public func setMaximised() {
        guard !isFullscreen else { return }
        isFullscreen = true
        previousParent = superview

        let parentVC = self.parentViewController
        let isPlaying = controllerView?.isPlaying() ?? false

        let newVC = AwesomeVideoFullscreenPlayer(withVideoPlayer: self, andIsCurrentlyPlaying: isPlaying)
        newVC.modalPresentationStyle = .fullScreen
        newVC.modalTransitionStyle = .coverVertical
        parentVC?.present(newVC, animated: true)
    }

    public func setMinimised() {
        guard isFullscreen else { return }
        isFullscreen = false
        let parentVC = parentViewController
        parentVC?.dismiss(animated: true)
        guard let previousParent = previousParent else { return }
        previousParent.addSubview(self)
        let isPlaying = controllerView?.isPlaying() ?? false
        if isPlaying {
            getAVPlayer()?.play()
        } else {
            getAVPlayer()?.pause()
        }
    }

    public func setDelegate(delegate: VideoPlayerDelegate?) {
        self.delegate = delegate
    }

    public func getAVPlayer() -> AVPlayer? {
        guard let player = controller as? AVPlayer else { return nil }
        return player
    }

    public func getAVPlayerLayer() -> AVPlayerLayer? {
        return playerLayer
    }

    // MARK: Init

    public init() {
        super.init(frame: .zero)
        accessibilityIdentifier = "SuperAwesome.Video.Player"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    ////////////////////////////////////////////////////////////////////////////
    // MediaControlDelegate
    ////////////////////////////////////////////////////////////////////////////

    public func didPrepare(control: VideoPlayerControls) {
        if let avcontrol = control as? AVPlayer {
            playerLayer?.removeFromSuperlayer()
            playerLayer = AVPlayerLayer(player: avcontrol)

            if let playerLayer = playerLayer {
                layer.addSublayer(playerLayer)
                control.start()
                delegate?.didPrepare(videoPlayer: self,
                                     time: control.getCurrentPosition(),
                                     duration: control.getDuration())

                controllerView?.setPlaying()
                subviews.forEach { bringSubviewToFront($0) }
                if let chrome = controllerView as? UIView {
                    bringSubviewToFront(chrome)
                }
            }
        }
    }

    public func didUpdateTime(control: VideoPlayerControls, time: Int, duration: Int) {
        controllerView?.setTime(time: time, duration: duration)
        delegate?.didUpdateTime(videoPlayer: self, time: control.getCurrentPosition(), duration: control.getDuration())
    }

    public func didCompleteMedia(control: VideoPlayerControls, time: Int, duration: Int) {
        controllerView?.setCompleted()
        delegate?.didComplete(videoPlayer: self, time: control.getCurrentPosition(), duration: control.getDuration())
    }

    public func didCompleteSeek(control: VideoPlayerControls) {
        // N/A
    }

    public func didError(control: VideoPlayerControls, error: Error, time: Int, duration: Int) {
        delegate?.didError(videoPlayer: self, error: error, time: 0, duration: 0)
    }

    public func didPause(control: VideoPlayerControls) {
        delegate?.didPause(videoPlayer: self)
    }

    public func didPlay(control: VideoPlayerControls) {
        delegate?.didPlay(videoPlayer: self)
    }

    ////////////////////////////////////////////////////////////////////////////
    // ChromeControlDelegate
    ////////////////////////////////////////////////////////////////////////////

    public func didStartProgressBarSeek() {
        // N/A
    }

    public func didEndProgressBarSeek(value: Float) {
        let totalSeconds = controller?.getDuration() ?? 0
        let value = CMTimeValue(value * Float(totalSeconds))
        let seekTime = CMTime(value: value, timescale: 1)
        controller?.seekTo(position: seekTime)
    }

    public func didTapPlay() {
        controller?.start()
    }

    public func didTapPause() {
        controller?.pause()
    }

    public func didTapReplay() {
        controller?.seekTo(position: CMTime(seconds: 0.0, preferredTimescale: 1))
        controller?.start()
    }

    public func didTapMaximise() {
        setMaximised()
    }

    public func didTapMinimise() {
        setMinimised()
    }
}
