//
//  AdModels.swift
//  SuperAwesome
//
//  Created by Gunhan Sancar on 15/04/2020.
//

public struct Ad: Codable {
    let isVpaid: Bool?
    let showPadlock: Bool
    public let lineItemId: Int
    let test: Bool
    public let creative: Creative
    let rnd: String?
    let adRequestId: String?

    enum CodingKeys: String, CodingKey {
        case isVpaid = "is_vpaid"
        case showPadlock = "show_padlock"
        case lineItemId = "line_item_id"
        case test
        case creative
        case rnd
        case adRequestId = "ad_request_id"
    }
}

struct AdQuery: Codable {
    let test: Bool
    let sdkVersion: String
    let random: Int
    let bundle: String
    let name: String
    let dauid: Int
    let connectionType: ConnectionType
    let lang: String
    let device: String
    let position: Int
    let skip: Int
    let playbackMethod: Int
    let startDelay: Int
    let instl: Int
    let width: Int
    let height: Int
    let openRtbPartnerId: String?
    let publisherConfiguration: String?

    enum CodingKeys: String, CodingKey {
        case test
        case sdkVersion
        case random = "rnd"
        case bundle
        case name
        case dauid
        case connectionType = "ct"
        case lang
        case device
        case position = "pos"
        case skip
        case playbackMethod = "playbackmethod"
        case startDelay = "startDelay"
        case instl
        case width = "w"
        case height = "h"
        case openRtbPartnerId
        case publisherConfiguration
    }
}

public struct AdRequest: Codable {
    let test: Bool
    let position: Position
    let skip: Skip
    let playbackMethod: Int
    let startDelay: StartDelay
    let instl: FullScreen
    let width: Int
    let height: Int
    let openRtbPartnerId: String?
    @CodableExcluded
    private(set)var options: [String: Any]?

    enum CodingKeys: String, CodingKey {
        case test
        case position = "pos"
        case skip
        case playbackMethod = "playbackmethod"
        case startDelay = "startdelay"
        case instl
        case width = "w"
        case height = "h"
        case openRtbPartnerId
    }
}

class AdResponse {
    let placementId: Int
    let advert: Ad
    let openRtbPartnerId: String?
    let requestOptions: [String: Any]?
    var html: String?
    var vast: VastAd?
    var baseUrl: String?
    var filePath: String?

    init(_ placementId: Int, _ advert: Ad, _ openRtbPartnerId: String?, _ requestOptions: [String: Any]?) {
        self.placementId = placementId
        self.advert = advert
        self.openRtbPartnerId = openRtbPartnerId
        self.requestOptions = requestOptions
    }

    /// Returns the aspect ratio of the ad's creative
    func aspectRatio() -> CGFloat {
        let width = advert.creative.details.width
        let height = advert.creative.details.height
        return CGFloat(width) / CGFloat(height)
    }

    /// Returns if the type of the ad is Vpaid
    var isVpaid: Bool {
        advert.isVpaid ?? false
    }
}

extension AdRequest {
    /// Specify if the ad is in full screen or not
    enum FullScreen: Int, Codable {
        case on = 1
        case off = 0
    }

    /// Playback method to enable sound at the beginning
    enum Playback: Int, Codable {
        /// Start with sound on
        case soundOn = 5
        /// Start with sound off
        case soundOff = 2

        static func from(_ muted: Bool) -> Playback {
            return muted ? soundOff : soundOn
        }
    }

    /// Start delay cases
    @objc
    public enum StartDelay: Int, Codable {
        case postRoll = -2
        case genericMidRoll = -1
        case preRoll = 0
        case midRoll = 1
    }

    /// Specify the position of the ad
    enum Position: Int, Codable {
        case aboveTheFold = 1
        case belowTheFold = 3
        case fullScreen = 7
    }

    /// Specify if the ad can be skipped
    enum Skip: Int, Codable {
        case no = 0
        case yes = 1
    }
}

@objc
public class StartDelayHelper: NSObject {
    /// Creates `StartDelay` enum from `int` value.
    @objc
    public class func from(_ value: Int) -> AdRequest.StartDelay {
        AdRequest.StartDelay(rawValue: value) ?? Constants.defaultStartDelay
    }
}

/**
 * This enum holds all the possible callback values that an ad sends during its lifetime
 *  - adLoaded:         ad was loaded successfully and is ready
 *                      to be displayed
 *  - adEmpty           the ad server returned an empty response
 *  - adFailedToLoad:   ad was not loaded successfully and will not be
 *                      able to play
 *  - adAlreadyLoaded   ad was previously loaded in an interstitial, video or
 *                      app wall queue
 *  - adShown:          triggered once when the ad first displays
 *  - adFailedToShow:   for some reason the ad failed to show; technically
 *                      this should never happen nowadays
 *  - adClicked:        triggered every time the ad gets clicked
 *  - adEnded:          triggerd when a video ad ends
 *  - adClosed:         triggered once when the ad is closed;
 *  - adPaused:        triggered once when the ad is paused;
 *  - adPlaying:        triggered once when the ad starts playing or resumes playing after a pause;
 *  - webSDKReady:        triggered when the WebSDK has finished loading and is ready;
 */
@objc(SAEvent)
public enum AdEvent: Int {
    case adLoaded = 0
    case adEmpty = 1
    case adFailedToLoad = 2
    case adAlreadyLoaded = 3
    case adShown = 4
    case adFailedToShow = 5
    case adClicked = 6
    case adEnded = 7
    case adClosed = 8
    case adPaused = 9
    case adPlaying = 10
    case webSDKReady = 11

    /// Gets the name of the event
    public func name() -> String {
        switch self {
        case .adLoaded: return "adLoaded"
        case .adEmpty: return "adEmpty"
        case .adFailedToLoad: return "adFailedToLoad"
        case .adAlreadyLoaded: return "adAlreadyLoaded"
        case .adShown: return "adShown"
        case .adFailedToShow: return "adFailedToShow"
        case .adClicked: return "adClicked"
        case .adEnded: return "adEnded"
        case .adClosed: return "adClosed"
        case .adPaused: return "adPaused"
        case .adPlaying: return "adPlaying"
        case .webSDKReady: return "webSDKReady"
        default: return "\(self.rawValue)"
        }
    }
}

/// Callback function for completable events
public typealias AdEventCallback = (_ placementId: Int, _ event: AdEvent) -> Void
