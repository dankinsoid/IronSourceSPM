//
//  AwesomeMediaControl.swift
//  Pods
//
//  Created by Gabriel Coman on 10/12/2018.
//

import AVFoundation
import AVKit
import Foundation

@objc(SAVideoPlayerController)
public class VideoPlayerController: AVPlayer, VideoPlayerControls {

    private let videoEndEvent = NSNotification.Name.AVPlayerItemDidPlayToEndTime
    private let periodicTimeInterval = CMTime(seconds: 1, preferredTimescale: 2)

    private var timeObserver: Any?

    public weak var delegate: VideoPlayerControlsDelegate?
    private let notif = NotificationCenter.default
    private let mainQueue = DispatchQueue.main
    private var didEndObserver: NSObjectProtocol?
    private var statusObserver: NSKeyValueObservation?
    private var item: AVPlayerItem?

    ////////////////////////////////////////////////////////////////////////////
    // Init
    ////////////////////////////////////////////////////////////////////////////

    public override init() {
        super.init()
        didEndObserver = notif.addObserver(forName: videoEndEvent,
                                           object: nil,
                                           queue: OperationQueue.main,
                                           using: { [weak self] notif in
            self?.didFinishPlaying(notif)
        })
    }

    deinit {
        removeObservers()
    }

    public func removeObservers() {
        if let uDidEndObserver = didEndObserver {
            notif.removeObserver(uDidEndObserver)
        }
        if let timeObserver = timeObserver {
            removeTimeObserver(timeObserver)
        }
        timeObserver = nil
        didEndObserver = nil
    }

    ////////////////////////////////////////////////////////////////////////////
    // MediaControl
    ////////////////////////////////////////////////////////////////////////////

    public func play(url: URL) {
        let asset = AVAsset(url: url)
        let playerItem = AVPlayerItem(asset: asset)
        item = playerItem

        statusObserver = item?.observe(
            \.status,
             options: [.old, .new]
        ) { [weak self] object, _ in
            self?.checkStatus(status: object.status)
        }

        replaceCurrentItem(with: playerItem)
        timeObserver = addPeriodicTimeObserver(forInterval: periodicTimeInterval,
                                               queue: mainQueue) { [weak self] time in
            self?.timeFunction(time)
        }
        delegate?.didPrepare(control: self)
    }

    public func start() {
        play()
    }

    override public func play() {
        super.play()
        delegate?.didPlay(control: self)
    }

    override public func pause() {
        super.pause()
        delegate?.didPause(control: self)
    }

    public func reset() {
        super.pause()
        statusObserver?.invalidate()
        statusObserver = nil
        replaceCurrentItem(with: nil)
        item = nil
    }

    public func destroy() {
        reset()
    }

    public func seekTo(position: CMTime) {
        seek(to: position)
    }

    public func getDuration() -> Int {
        guard let duration = item?.duration, duration != CMTime.indefinite else {
            return 0
        }
        let seconds = CMTimeGetSeconds(duration)
        return Int(seconds)
    }

    public func getCurrentPosition() -> Int {
        guard let time = item?.currentTime(), time != CMTime.indefinite else {
            return 0
        }
        let seconds = CMTimeGetSeconds(time)
        return Int(seconds)
    }

    ////////////////////////////////////////////////////////////////////////////
    // Set delegate
    ////////////////////////////////////////////////////////////////////////////

    public func set(delegate: VideoPlayerControlsDelegate) {
        self.delegate = delegate
    }

    ////////////////////////////////////////////////////////////////////////////
    // Different observers
    ////////////////////////////////////////////////////////////////////////////

    @objc
    private func didFinishPlaying(_ notification: Notification) {
        mainQueue.async { [weak self] in
            self?.didCompleteMedia()
        }
    }

    private func didCompleteMedia() {
        delegate?.didCompleteMedia(control: self,
                                   time: getCurrentPosition(),
                                   duration: getDuration())
    }

    private func timeFunction(_ time: CMTime) {
        let time = CMTimeGetSeconds(time)
        delegate?.didUpdateTime(control: self, time: Int(time), duration: getDuration())
    }

    private func checkStatus(status: AVPlayerItem.Status) {
        if status == .failed, let error = item?.error as NSError? {
            delegate?.didError(control: self,
                               error: error,
                               time: getDuration(),
                               duration: getCurrentPosition())
        }
    }
}
