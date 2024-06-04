//
//  MediaControl.swift
//  Pods
//
//  Created by Gabriel Coman on 10/12/2018.
//

import AVFoundation
import AVKit
import Foundation

/**
 * This protocol defines the public interface for any object that can be
 * used to control a piece of media.
 */
@objc(SAVideoPlayerControls)
public protocol VideoPlayerControls: AnyObject {

    /**
     * Method that starts playing a piece of media
     * @param url - the url of a valid piece of media (remote or local)
     */
    @objc(play:)
    func play(url: URL)

    /**
     * Method that resumes the media play
     */
    @objc(start)
    func start()

    /**
     * Method that pauses the media play
     */
    @objc(pause)
    func pause()

    /**
     * Method that resets the state of the MediaControl, but should
     * not release all resources so that it becomes unavailable
     */
    @objc(reset)
    func reset()

    /**
     * Method that frees up all resources owned by the MediaControl;
     * From here on, it cannot be re-used to play media
     */
    @objc(destroy)
    func destroy()

    /**
     * Method to seek to a different position
     */
    @objc(seekTo:)
    func seekTo(position: CMTime)

    /**
     * Method that returns the total duration, in seconds, of the
     * media control
     */
    @objc(duration)
    func getDuration() -> Int

    /**
     * Method that returns the current position, in seconds, of the
     * media control
     */
    @objc(currentPosition)
    func getCurrentPosition() -> Int

    /**
     * Method to set the MediaControl's delegate
     * @param delegate - a reference to an object implementing the MediaControlDelegate protocol
     */
    @objc(setDelegate:)
    func set(delegate: VideoPlayerControlsDelegate)
}

/**
 * The associated delegate of the media control
 */
@objc(SAVideoPlayerControlsDelegate)
public protocol VideoPlayerControlsDelegate: AnyObject {

    /**
     * This method is called by the VideoPlayerControls when the media is prepared
     * @param control - the current media control instance
     */
    @objc(didPrepareControl:)
    func didPrepare(control: VideoPlayerControls)

    /**
     * This method is called by the VideoPlayerControls when the time has been updated
     * @param control - the current media control instance
     * @param time - the current media time
     * @param duration - the total duration of the media
     */
    @objc(didPrepareControl:withTime:andDuration:)
    func didUpdateTime(control: VideoPlayerControls, time: Int, duration: Int)

    /**
     * This method is called by the VideoPlayerControls when the media is finished
     * @param control - the current media control instance
     * @param time - the current media time
     * @param duration - the total duration of the media
     */
    @objc(didCompleteControl:withTime:andDuration:)
    func didCompleteMedia(control: VideoPlayerControls, time: Int, duration: Int)

    /**
     * This method is called by the VideoPlayerControls when seeking is over
     * @param control - the current media control instance
     */
    @objc(didCompleteSeekOnControl:)
    func didCompleteSeek(control: VideoPlayerControls)

    /**
     * This method is called by the VideoPlayerControls when an error happened
     * @param control - the current media control instance
     * @param time - the current media time
     * @param duration - the total duration of the media
     */
    @objc(didErrorOnControl:withError:andTime:andDuration:)
    func didError(control: VideoPlayerControls, error: Error, time: Int, duration: Int)

    /**
     * This method is called by the VideoPlayerControls when the player is paused
     * @param control - the current media control instance
     */
    @objc(didPauseOnControl:)
    func didPause(control: VideoPlayerControls)

    /**
     * This method is called by the VideoPlayerControls when the player is playing or resumes
     * @param control - the current media control instance
     */
    @objc(didPlayControl:)
    func didPlay(control: VideoPlayerControls)
}
