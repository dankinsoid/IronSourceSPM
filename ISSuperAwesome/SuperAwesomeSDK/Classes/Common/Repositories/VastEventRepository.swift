//
//  VastEventRepository.swift
//  SuperAwesome
//
//  Created by Gunhan Sancar on 09/09/2020.
//

protocol VastEventRepositoryType {
    func error()
    func impression()
    func creativeView()
    func start()
    func firstQuartile()
    func midPoint()
    func thirdQuartile()
    func complete()
    func clickTracking()
}

class VastEventRepository: VastEventRepositoryType {
    private let adResponse: AdResponse
    private let networkDataSource: NetworkDataSourceType
    private let logger: LoggerType

    init(adResponse: AdResponse, networkDataSource: NetworkDataSourceType, logger: LoggerType) {
        self.adResponse = adResponse
        self.networkDataSource = networkDataSource
        self.logger = logger
    }

    private func customEvent(_ urls: [String]?) {
        urls?.forEach {
            networkDataSource.getData(url: $0, completion: nil)
        }
    }

    func error() {
        logger.info("error event")
        customEvent(adResponse.vast?.errorEvents)
    }

    func impression() {
        logger.info("impression event")
        customEvent(adResponse.vast?.impressionEvents)
    }

    func creativeView() {
        logger.info("creativeView event")
        customEvent(adResponse.vast?.creativeViewEvents)
    }

    func start() {
        logger.info("start event")
        customEvent(adResponse.vast?.startEvents)
    }

    func firstQuartile() {
        logger.info("firstQuartile event")
        customEvent(adResponse.vast?.firstQuartileEvents)
    }

    func midPoint() {
        logger.info("midPoint event")
        customEvent(adResponse.vast?.midPointEvents)
    }

    func thirdQuartile() {
        logger.info("thirdQuartile event")
        customEvent(adResponse.vast?.thirdQuartileEvents)
    }

    func complete() {
        logger.info("complete event")
        customEvent(adResponse.vast?.completeEvents)
    }

    func clickTracking() {
        logger.info("clickTracking event")
        customEvent(adResponse.vast?.clickTrackingEvents)
    }
}
