//
//  EventRepository.swift
//  SuperAwesome
//
//  Created by Gunhan Sancar on 29/04/2020.
//

protocol EventRepositoryType {
    func impression(_ adResponse: AdResponse, completion: OnResult<EmptyResponse>?)
    func click(_ adResponse: AdResponse, completion: OnResult<EmptyResponse>?)
    func videoClick(_ adResponse: AdResponse, completion: OnResult<EmptyResponse>?)
    func parentalGateOpen(_ adResponse: AdResponse, completion: OnResult<EmptyResponse>?)
    func parentalGateClose(_ adResponse: AdResponse, completion: OnResult<EmptyResponse>?)
    func parentalGateSuccess(_ adResponse: AdResponse, completion: OnResult<EmptyResponse>?)
    func parentalGateFail(_ adResponse: AdResponse, completion: OnResult<EmptyResponse>?)
    func viewableImpression(_ adResponse: AdResponse, completion: OnResult<EmptyResponse>?)
    func dwellTime(_ adResponse: AdResponse, completion: OnResult<EmptyResponse>?)
}

class EventRepository: EventRepositoryType {
    private let dataSource: AwesomeAdsApiDataSourceType
    private let adQueryMaker: AdQueryMakerType
    private let logger: LoggerType

    init(dataSource: AwesomeAdsApiDataSourceType, adQueryMaker: AdQueryMakerType, logger: LoggerType) {
        self.dataSource = dataSource
        self.adQueryMaker = adQueryMaker
        self.logger = logger
    }

    func impression(_ adResponse: AdResponse, completion: OnResult<EmptyResponse>?) {
        logger.info("Event Tracking: impression sent for \(adResponse.placementId)")
        dataSource.impression(query: adQueryMaker.makeImpressionQuery(adResponse), completion: completion)
    }

    func click(_ adResponse: AdResponse, completion: OnResult<EmptyResponse>?) {
        logger.info("Event Tracking: click sent for \(adResponse.placementId)")
        dataSource.click(query: adQueryMaker.makeClickQuery(adResponse), completion: completion)
    }

    func videoClick(_ adResponse: AdResponse, completion: OnResult<EmptyResponse>?) {
        logger.info("Event Tracking: videoClick sent for \(adResponse.placementId)")
        dataSource.videoClick(query: adQueryMaker.makeClickQuery(adResponse), completion: completion)
    }

    func parentalGateOpen(_ adResponse: AdResponse, completion: OnResult<EmptyResponse>?) {
        customEvent(.parentalGateOpen, adResponse, completion: completion)
    }

    func parentalGateClose(_ adResponse: AdResponse, completion: OnResult<EmptyResponse>?) {
        customEvent(.parentalGateClose, adResponse, completion: completion)
    }

    func parentalGateSuccess(_ adResponse: AdResponse, completion: OnResult<EmptyResponse>?) {
        customEvent(.parentalGateSuccess, adResponse, completion: completion)
    }

    func parentalGateFail(_ adResponse: AdResponse, completion: OnResult<EmptyResponse>?) {
        customEvent(.parentalGateFail, adResponse, completion: completion)
    }

    func viewableImpression(_ adResponse: AdResponse, completion: OnResult<EmptyResponse>?) {
        customEvent(.viewableImpression, adResponse, completion: completion)
    }

    func dwellTime(_ adResponse: AdResponse, completion: OnResult<EmptyResponse>?) {
        customEvent(.dwellTime, adResponse, value: 5, completion: completion)
    }

    private func customEvent(_ type: EventType,
                             _ adResponse: AdResponse,
                             value: Int? = nil,
                             completion: OnResult<EmptyResponse>?) {
        let data = EventData(placement: adResponse.placementId,
                             lineItem: adResponse.advert.lineItemId,
                             creative: adResponse.advert.creative.id,
                             value: value,
                             type: type)
        logger.info("Event Tracking: \(type.rawValue) sent for \(adResponse.placementId)")
        dataSource.event(query: adQueryMaker.makeEventQuery(adResponse, data), completion: completion)
    }
}
