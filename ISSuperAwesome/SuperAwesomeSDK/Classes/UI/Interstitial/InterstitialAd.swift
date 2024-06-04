//
//  InterstitialAd.swift
//  SuperAwesome
//
//  Created by Gunhan Sancar on 04/09/2020.
//

import UIKit

@objc(SAInterstitialAd)
public class InterstitialAd: NSObject, Injectable {
    private static var controller: AdControllerType = dependencies.resolve()
    private static var logger: LoggerType = dependencies.resolve(param: InterstitialAd.self)

    private(set) static var isParentalGateEnabled: Bool = Constants.defaultParentalGate
    private(set) static var isBumperPageEnabled: Bool = Constants.defaultBumperPage
    private(set) static var isTestingEnabled: Bool = Constants.defaultTestMode
    private(set) static var orientation: Orientation = Constants.defaultOrientation
    private(set) static var closeButtonState: CloseButtonState = Constants.defaultCloseButtonInterstitial
    private(set) static var closeButtonDelay: TimeInterval = Constants.defaultCloseButtonDelay

    // MARK: - Public functions

    /**
     * Method that loads an ad into the queue.
     * Ads can only be loaded once and then can be reloaded after they've
     * been played.
     *
     * - Parameters:
     *  - placementId: The Ad placement id to load data for
     */
    @objc
    public class func load(_ placementId: Int) {
        load(placementId, openRtbPartnerId: nil, options: nil)
    }

    /**
     * Method that loads an ad into the queue.
     * Ads can only be loaded once and then can be reloaded after they've
     * been played.
     *
     * - Parameters:
     *  - placementId: The Ad placement id to load data for
     *  - openRtbPartnerId: optional OpenRTB Partner ID
     */
    @objc
    public class func load(_ placementId: Int, openRtbPartnerId: String? = nil) {
        load(placementId, openRtbPartnerId: openRtbPartnerId, options: nil)
    }

    /**
     * Method that loads an ad into the queue.
     * Ads can only be loaded once and then can be reloaded after they've
     * been played.
     *
     * - Parameters:
     *  - placementId: The Ad placement id to load data for
     *  - openRtbPartnerId: optional OpenRTB Partner ID
     *  - options: an optional dictionary of data to send with an ad's requests and events. Supports String or Int values.
     */
    @objc
    public class func load(_ placementId: Int, openRtbPartnerId: String? = nil, options: [String: Any]? = nil) {
        logger.info("load() for: \(placementId)")
        controller.load(placementId,
                        makeAdRequest(with: options, openRtbPartnerId: openRtbPartnerId),
                        pubConfig: InterstitialAd.buildPubConfig())
    }

        /**
         * Method that loads an ad into the queue.
         * Ads can only be loaded once and then can be reloaded after they've
         * been played.
         *
         * - Parameters:
         *  - placementId: the Ad placement id to load data for
         *  - lineItemId: id of the line item
         *  - creativeId: id of the creative
         */
        @objc
        public class func load(_ placementId: Int, lineItemId: Int, creativeId: Int) {
            load(placementId,
                 lineItemId: lineItemId,
                 creativeId: creativeId,
                 openRtbPartnerId: nil,
                 options: nil)
        }

    /**
     * Method that loads an ad into the queue.
     * Ads can only be loaded once and then can be reloaded after they've
     * been played.
     *
     * - Parameters:
     *  - placementId: the Ad placement id to load data for
     *  - lineItemId: id of the line item
     *  - creativeId: id of the creative
     *  - openRtbPartnerId: optional OpenRTB Partner ID
     */
    @objc
    public class func load(_ placementId: Int, lineItemId: Int, creativeId: Int, openRtbPartnerId: String? = nil) {
        load(placementId,
             lineItemId: lineItemId,
             creativeId: creativeId,
             openRtbPartnerId: openRtbPartnerId,
             options: nil)
    }

    /**
     * Method that loads an ad into the queue.
     * Ads can only be loaded once and then can be reloaded after they've
     * been played.
     *
     * - Parameters:
     *  - placementId: the Ad placement id to load data for
     *  - lineItemId: id of the line item
     *  - creativeId: id of the creative
     *  - openRtbPartnerId: optional OpenRTB Partner ID
     *  - options: an optional dictionary of data to send with an ad's requests and events. Supports String or Int values.
     */
    @objc
    public class func load(_ placementId: Int,
                           lineItemId: Int,
                           creativeId: Int,
                           openRtbPartnerId: String? = nil,
                           options: [String: Any]? = nil) {
        logger.info("load() for placement Id: \(placementId) lineItemId: \(lineItemId), creativeId: \(creativeId)")
        controller.load(placementId,
                        lineItemId: lineItemId,
                        creativeId: creativeId,
                        makeAdRequest(with: options, openRtbPartnerId: openRtbPartnerId),
                        pubConfig: InterstitialAd.buildPubConfig())
    }

    /**
     * Method that, if an ad data is loaded, will play
     * the content for the user
     *
     * - Parameters:
     *  - placementId: The Ad placement id to play an ad for
     *  - parent:  The parent view controller
     */
    @objc
    public class func play(_ placementId: Int, fromVC parent: UIViewController?) {
        logger.info("play()")
        // guard against invalid ad formats
        guard let adResponse = controller.adResponse,
              adResponse.advert.creative.format != CreativeFormatType.video else {
            controller.adFailedToShow()
            return
        }

        let viewController = InterstitialAdViewController(adResponse: adResponse,
                                                          parentGateEnabled: isParentalGateEnabled,
                                                          bumperPageEnabled: isBumperPageEnabled,
                                                          closeButtonState: closeButtonState,
                                                          closeButtonDelay: closeButtonDelay,
                                                          testingEnabled: isTestingEnabled,
                                                          orientation: orientation,
                                                          delegate: self.controller.callback)
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .coverVertical
        parent?.present(viewController, animated: true, completion: nil)
    }

    /**
     * Method that returns whether ad data for a certain placement
     * has already been loaded
     * - Parameter placementId: the Ad placement id to check for
     * - Returns:  true or false
     */
    @objc
    @available(*, deprecated, message: "Use new version without placementId parameter")
    public class func hasAdAvailable(_ placementId: Int) -> Bool { controller.adAvailable }

    /**
     * Method that returns whether ad data has already been loaded.
     * - Returns:  true or false
     */
    @objc
    public class func hasAdAvailable() -> Bool { controller.adAvailable }

    /**
     * Method that enables the close button to display with a delay.
     */
    @objc(enableCloseButton)
    public static func enableCloseButton() {
        closeButtonState = .visibleWithDelay
    }

    /**
     * Method that enables the close button to display immediately without a delay.
     * WARNING: this will allow users to close the ad before the viewable tracking event is fired
     * and should only be used if you explicitly want this behaviour over consistent tracking.
     */
    @objc(enableCloseButtonNoDelay)
    public static func enableCloseButtonNoDelay() {
        closeButtonState = .visibleImmediately
    }

    /**
     * Method that enables the close button to display with a specified delay.
     * WARNING: this will change any previous close button settings.
     */
    @objc(enableCloseButtonTimeIntervalWithCustomDelay:)
    public static func enableCloseButtonWithCustomDelay(delay: TimeInterval) {
        closeButtonState = .custom
        closeButtonDelay = delay
    }

    @objc
    public class func setCallback(_ callback: @escaping AdEventCallback) { controller.callback = callback }

    @available(*, deprecated, message: "Use `AwesomeAds.initSDK()` to select configuration")
    @objc
    public class func setConfiguration(_ value: Int) { }

    @available(*, deprecated, message: "Use `AwesomeAds.initSDK()` to select configuration")
    @objc
    public class func setConfigurationProduction() { }

    @available(*, deprecated, message: "Use `AwesomeAds.initSDK()` to select configuration")
    @objc
    public class func setConfigurationStaging() { }

    @objc
    public class func setOrientation(_ orientation: Orientation) { self.orientation = orientation }

    @objc
    public class func setOrientationAny() { setOrientation(.any) }

    @objc
    public class func setOrientationPortrait() { setOrientation(.portrait) }

    @objc
    public class func setOrientationLandscape() { setOrientation(.landscape) }

    @objc
    public class func setTestMode(_ value: Bool) { isTestingEnabled = value }

    @objc
    public class func enableTestMode() { setTestMode(true) }

    @objc
    public class func disableTestMode() { setTestMode(false) }

    @objc
    public class func setBumperPage(_ value: Bool) { isBumperPageEnabled = value }

    @objc
    public class func enableBumperPage() { setBumperPage(true) }

    @objc
    public class func disableBumperPage() { setBumperPage(false) }

    @objc
    public class func setParentalGate(_ value: Bool) { isParentalGateEnabled = value }

    @objc
    public class func enableParentalGate() { setParentalGate(true) }

    @objc
    public class func disableParentalGate() { setParentalGate(false) }

    // MARK: - Private functions

    private static func makeAdRequest(with options: [String: Any]?, openRtbPartnerId: String?) -> AdRequest {
        let size = UIScreen.main.bounds.size

        return AdRequest(test: isTestingEnabled,
                         position: AdRequest.Position.fullScreen,
                         skip: AdRequest.Skip.yes,
                         playbackMethod: AdRequest.Playback.soundOn.rawValue,
                         startDelay: AdRequest.StartDelay.preRoll,
                         instl: AdRequest.FullScreen.on,
                         width: Int(size.width),
                         height: Int(size.height),
                         openRtbPartnerId: openRtbPartnerId,
                         options: options)
    }

    private static func buildPubConfig() -> PublisherConfig {
        PublisherConfig(parentalGateOn: isParentalGateEnabled,
                        bumperPageOn: isBumperPageEnabled,
                        closeWarning: nil,
                        orientation: orientation,
                        closeAtEnd: nil,
                        muteOnStart: nil,
                        showMore: nil,
                        startDelay: nil,
                        closeButtonState: closeButtonState)
    }
}
