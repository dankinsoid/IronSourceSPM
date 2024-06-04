//
//  VideoPlayer.swift
//  SAVideoPlayer
//
//  Created by Gabriel Coman on 17/01/2019.
//

import AVFoundation
import AVKit
import Foundation

/**
 * This protocol defines the public interface for a video player.
 * A video player brings together a:
 * - media control
 * - chrome control
 * - video surfaces
 * to play local or remote videos
 */
@objc(SAVideoPlayer)
public protocol VideoPlayer: VideoPlayerControlsDelegate, VideoPlayerControlsViewDelegate {

    /**
     * Sets the media control for the video player
     * @param control - an instance of an object that implements the MediaControl protocol
     */
    @objc(setControls:)
    func setControls(controller: VideoPlayerControls)

    /**
     * Sets the chrome control for the video player
     * @param chrome - an instance of an object that implements the ChromeControl protocol
     * @param insets - the insets for the VideoPlayerControlsView
     */
    @objc(setConstrolsView:insets:)
    func setControlsView(controllerView: VideoPlayerControlsView, insets: UIEdgeInsets)

    /**
     * Sets the state of the video to maximised
     */
    @objc(maximise)
    func setMaximised()

    /**
     * Sets the state of the video to minimised
     */
    @objc(minimise)
    func setMinimised()

    /**
     * Destroy & release the whole video player
     */
    @objc(destroy)
    func destroy()

    /**
     * Return the current AVPlayer
     */
    @objc(avPlayer)
    func getAVPlayer() -> AVPlayer?

    /**
     * Return the current AVPlayerLayer
     */
    @objc(avPlayerLayer)
    func getAVPlayerLayer() -> AVPlayerLayer?

    /**
     *Set the delegate of the VideoPlayer protocol
     * @param delegate - an instance of an object that implements VideoPlayerDelegate
     */
    @objc(setDelegate:)
    func setDelegate(delegate: VideoPlayerDelegate?)
}

/**
 * The Delegate of the video player
 */
@objc(SAVideoPlayerDelegate)
public protocol VideoPlayerDelegate: AnyObject {
    /**
     * This method is called by the video player when it is prepared and
     * has started to play a video
     * @param videoPlayer - the current videoPlayer instance
     * @param time - the current time of the video player
     * @param duration - the current total duration of the video player
     */
    @objc(didPrepareVideoPlayer:withTime:andDuration:)
    func didPrepare(videoPlayer: VideoPlayer, time: Int, duration: Int)

    /**
     * This method is called by the video player when it has updated the time
     * @param videoPlayer - the current videoPlayer instance
     * @param time - the current time of the video player
     * @param duration - the current total duration of the video player
     */
    @objc(didUpdateTimeForVideoPlayer:withTime:andDuration:)
    func didUpdateTime(videoPlayer: VideoPlayer, time: Int, duration: Int)

    /**
     * This method is called by the video player when it has finished playing
     * @param videoPlayer - the current videoPlayer instance
     * @param time - the current time of the video player
     * @param duration - the current total duration of the video player
     */
    @objc(didCompleteVideoPlayer:withTime:andDuration:)
    func didComplete(videoPlayer: VideoPlayer, time: Int, duration: Int)

    /**
     * This method is called by the video player when it has encountered an error
     * @param videoPlayer - the current videoPlayer instance
     * @param time - the current time of the video player
     * @param duration - the current total duration of the video player
     */
    @objc(didErrorVideoPlayer:withError:withTime:andDuration:)
    func didError(videoPlayer: VideoPlayer, error: Error, time: Int, duration: Int)

    /**
     * This method is called by the video player when it has paused
     * @param videoPlayer - the current videoPlayer instance
     */
    @objc(didPauseVideoPlayer:)
    func didPause(videoPlayer: VideoPlayer)

    /**
     * This method is called by the video player when it is playing / has resumed
     * @param videoPlayer - the current videoPlayer instance
     */
    @objc(didPlayVideoPlayer:)
    func didPlay(videoPlayer: VideoPlayer)
}
