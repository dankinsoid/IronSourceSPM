//
//  ChromeControl.swift
//  Pods
//
//  Created by Gabriel Coman on 10/12/2018.
//

import Foundation

/**
 * This protocol defines the public interface of a video's chrome
 * (that is also used to control the video from the user's perspective)
 */
@objc(SAVideoPlayerControlsView)
public protocol VideoPlayerControlsView: AnyObject {

    /**
     * Method that sets the chrome in the playing state
     */
    @objc(setPlaying)
    func setPlaying()

    /**
     * Method that sets the chrome in the paused state
     */
    @objc(setPaused)
    func setPaused()

    /**
     * Method that sets the chrome in the completed state
     */
    @objc(setCompleted)
    func setCompleted()

    /**
     * Method that sets the chrome in the error state
     * @param: error - the error object
     */
    @objc(setError:)
    func setError(error: Error)

    /**
     * Method that updates the chrome's time and duration
     * @param time current time
     * @param duration current duration
     */
    @objc(setTime:andDuration:)
    func setTime(time: Int, duration: Int)

    /**
     * @return whether the chrome element is in a playing state or not
     */
    @objc(isPlaying)
    func isPlaying() -> Bool

    /**
     * Method that sets the chrome in the visible state
     */
    @objc(show)
    func show()

    /**
     * Method that sets the chrome in the invisible state
     */
    @objc(hide)
    func hide()

    /**
     * Method that sets the chrome in the minimised state
     */
    @objc(setMinimised)
    func setMinimised()

    /**
     * Method that sets the chrome in the maximised state
     */
    @objc(setMaximised)
    func setMaximised()

    /**
     * Method that returns whether the chrome is in maximised or minimised state
     */
    @objc(isMaximised)
    func isMaximised() -> Bool

    /**
     * Method that sets the delegate of the ChromeControl
     */
    @objc(setDelegate:)
    func set(delegate: VideoPlayerControlsViewDelegate)

    /**
     * Method that sets an event listener
     */
    @objc(setListener:)
    func set(controlsViewListener: VideoPlayerControlsViewDelegate)
}

/**
 * The associated delegate of chrome control
 */
@objc(SAVideoPlayerControlsViewDelegate)
public protocol VideoPlayerControlsViewDelegate: AnyObject {

    /**
     * This method is called by the chrome control when the progress
     * bar has started to move
     */
    @objc(didStartProgressBarSeek)
    func didStartProgressBarSeek()

    /**
     * This method is called by the chrome control when the progress
     * bar has finished to move
     * @param value - the value the chrome has seeked to
     */
    @objc(didEndProgressBarSeek:)
    func didEndProgressBarSeek(value: Float)

    /**
     * This method is called by the chrome control when the
     * play button has been tapped
     */
    @objc(didTapPlay)
    func didTapPlay()

    /**
     * This method is called by the chrome control when the
     * pause button has been tapped
     */
    @objc(didTapPause)
    func didTapPause()

    /**
     * This method is called by the chrome control when the
     * replayu button has been tapped
     */
    @objc(didTapReplay)
    func didTapReplay()

    /**
     * This method is called by the chrome control when the
     * maximise button has been tapped
     */
    @objc(didTapMaximise)
    func didTapMaximise()

    /**
     * This method is called by the chrome control when the
     * minimise button has been tapped
     */
    @objc(didTapMinimise)
    func didTapMinimise()
}
