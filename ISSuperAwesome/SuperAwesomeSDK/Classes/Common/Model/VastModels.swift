//
//  VastModels.swift
//  SuperAwesome
//
//  Created by Gunhan Sancar on 06/07/2020.
//

class VastAd {
    let url: String?
    private(set) var redirect: String?
    let type: VastType
    let media: [VastMedia]

    private(set) var clickThroughUrl: String?
    private(set) var errorEvents: [String] = []
    private(set) var impressionEvents: [String] = []
    private(set) var creativeViewEvents: [String] = []
    private(set) var startEvents: [String] = []
    private(set) var firstQuartileEvents: [String] = []
    private(set) var midPointEvents: [String] = []
    private(set) var thirdQuartileEvents: [String] = []
    private(set)  var completeEvents: [String] = []
    private(set)  var clickTrackingEvents: [String] = []

    init(
        url: String? = nil,
        type: VastType,
        redirect: String? = nil,
        errorEvents: [String] = [],
        impressions: [String] = [],
        clickThrough: String? = nil,
        creativeViewEvents: [String] = [],
        startEvents: [String] = [],
        firstQuartileEvents: [String] = [],
        midPointEvents: [String] = [],
        thirdQuartileEvents: [String] = [],
        completeEvents: [String] = [],
        clickTrackingEvents: [String] = [],
        media: [VastMedia] = []) {
        self.url = url
        self.redirect = redirect
        self.type = type
        self.media = media
        self.errorEvents = errorEvents
        self.impressionEvents = impressions
        self.creativeViewEvents = creativeViewEvents
        self.clickThroughUrl = clickThrough
        self.startEvents = startEvents
        self.firstQuartileEvents = firstQuartileEvents
        self.midPointEvents = midPointEvents
        self.thirdQuartileEvents = thirdQuartileEvents
        self.completeEvents = completeEvents
        self.clickTrackingEvents = clickTrackingEvents

    }

    func merge(from: VastAd?) -> VastAd {
        guard let from = from else { return self }

        return VastAd(url: from.url ?? self.url,
               type: type,
               redirect: nil,
               errorEvents: errorEvents + from.errorEvents,
               impressions: impressionEvents + from.impressionEvents,
               clickThrough: from.clickThroughUrl ?? self.clickThroughUrl,
               startEvents: startEvents + from.startEvents,
               firstQuartileEvents: firstQuartileEvents + from.firstQuartileEvents,
               midPointEvents: midPointEvents + from.midPointEvents,
               thirdQuartileEvents: thirdQuartileEvents +  from.thirdQuartileEvents,
               completeEvents: completeEvents + from.completeEvents,
               clickTrackingEvents: clickTrackingEvents + from.clickTrackingEvents,
               media: media + from.media)

    }
}

enum VastType {
    case invalid
    case inLine
    case wrapper
}

struct VastMedia {
    var type: String?
    var url: String?
    var bitrate: Int?
    var width: Int?
    var height: Int?
}

struct VastEvent {
    let event: String
    let url: String
}
