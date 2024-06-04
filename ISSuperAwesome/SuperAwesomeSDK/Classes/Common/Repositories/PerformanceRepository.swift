//
//  PerformanceRepository.swift
//  SuperAwesome
//
//  Created by Gunhan Sancar on 02/06/2023.
//

protocol PerformanceRepositoryType {
    func sendCloseButtonPressTime(adResponse: AdResponse, value: Int64, completion: OnResult<EmptyResponse>?)
    func sendDwellTime(adResponse: AdResponse, value: Int64, completion: OnResult<EmptyResponse>?)
    func sendLoadTime(adResponse: AdResponse, value: Int64, completion: OnResult<EmptyResponse>?)
    func sendRenderTime(adResponse: AdResponse, value: Int64, completion: OnResult<EmptyResponse>?)
    func sendCloseButtonFallbackShown(adResponse: AdResponse, completion: OnResult<EmptyResponse>?)
}

class PerformanceRepository: PerformanceRepositoryType, Injectable {

    private let dataSource: AwesomeAdsApiDataSourceType
    private let sdkInfo: SdkInfoType = dependencies.resolve()
    private let connectionProvider: ConnectionProviderType = dependencies.resolve()
    private let logger: LoggerType

    init(dataSource: AwesomeAdsApiDataSourceType, logger: LoggerType) {
        self.dataSource = dataSource
        self.logger = logger
    }

    func sendCloseButtonPressTime(adResponse: AdResponse,
                                  value: Int64,
                                  completion: OnResult<EmptyResponse>?) {

        let metric = PerformanceMetric(value: value,
                                       metricName: .closeButtonPressTime,
                                       metricType: .gauge,
                                       metricTags: buildMetricTags(adResponse: adResponse))

        dataSource.performance(metric: metric, completion: completion)
    }

    func sendDwellTime(adResponse: AdResponse,
                       value: Int64,
                       completion: OnResult<EmptyResponse>?) {

        let metric = PerformanceMetric(value: value,
                                       metricName: .dwellTime,
                                       metricType: .gauge,
                                       metricTags: buildMetricTags(adResponse: adResponse))

        dataSource.performance(metric: metric, completion: completion)
    }

    func sendLoadTime(adResponse: AdResponse,
                      value: Int64,
                      completion: OnResult<EmptyResponse>?) {

        let metric = PerformanceMetric(value: value,
                                       metricName: .loadTime,
                                       metricType: .gauge,
                                       metricTags: buildMetricTags(adResponse: adResponse))

        dataSource.performance(metric: metric, completion: completion)
    }

    func sendRenderTime(adResponse: AdResponse,
                        value: Int64,
                        completion: OnResult<EmptyResponse>?) {

        let metric = PerformanceMetric(value: value,
                                       metricName: .renderTime,
                                       metricType: .gauge,
                                       metricTags: buildMetricTags(adResponse: adResponse))

        dataSource.performance(metric: metric, completion: completion)
    }

    func sendCloseButtonFallbackShown(adResponse: AdResponse,
                                      completion: OnResult<EmptyResponse>?) {

        let metric = PerformanceMetric(value: 1,
                                       metricName: .closeButtonFallbackShown,
                                       metricType: .increment,
                                       metricTags: buildMetricTags(adResponse: adResponse))

        dataSource.performance(metric: metric, completion: completion)
    }

    private func buildMetricTags(adResponse: AdResponse) -> PerformanceMetricTags {
        PerformanceMetricTags(sdkVersion: sdkInfo.version,
                              placementId: String(adResponse.placementId),
                              lineItemId: String(adResponse.advert.lineItemId),
                              creativeId: String(adResponse.advert.creative.id),
                              connectionType: String(connectionProvider.findConnectionType().rawValue),
                              format: adResponse.advert.creative.format)
    }
}
