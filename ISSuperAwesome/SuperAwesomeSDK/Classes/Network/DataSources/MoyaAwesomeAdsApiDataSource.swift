//
//  MoyaAdDataSource.swift
//  SuperAwesome
//
//  Created by Gunhan Sancar on 23/04/2020.
//

import Moya

class MoyaAwesomeAdsApiDataSource: AwesomeAdsApiDataSourceType {

    private let provider: MoyaProvider<AwesomeAdsTarget>
    private let environment: Environment
    private let retryDelay: TimeInterval
    private let logger: LoggerType

    init(provider: MoyaProvider<AwesomeAdsTarget>,
         environment: Environment,
         retryDelay: TimeInterval,
         logger: LoggerType) {
        self.provider = provider
        self.environment = environment
        self.retryDelay = retryDelay
        self.logger = logger
    }

    func getAd(placementId: Int, query: QueryBundle, completion: @escaping OnResult<Ad>) {
        let target = AwesomeAdsTarget(environment, .ad(placementId: placementId, query: query))
        responseHandler(target: target, completion: completion)
    }

    func getAd(placementId: Int,
               lineItemId: Int,
               creativeId: Int,
               query: QueryBundle,
               completion: @escaping OnResult<Ad>) {
        let target = AwesomeAdsTarget(
            environment,
            .adByPlacementLineAndCreativeId(
                placementId: placementId,
                lineItemId: lineItemId,
                creativeId: creativeId,
                query: query
            )
        )
        responseHandler(target: target, completion: completion)
    }

    func impression(query: QueryBundle, completion: OnResult<EmptyResponse>?) {
        let target = AwesomeAdsTarget(environment, .impression(query: query))
        responseHandler(target: target, completion: completion)
    }

    func click(query: QueryBundle, completion: OnResult<EmptyResponse>?) {
        let target = AwesomeAdsTarget(environment, .click(query: query))
        responseHandler(target: target, completion: completion)
    }

    func videoClick(query: QueryBundle, completion: OnResult<EmptyResponse>?) {
        let target = AwesomeAdsTarget(environment, .videoClick(query: query))
        responseHandler(target: target, completion: completion)
    }

    func event(query: QueryBundle, completion: OnResult<EmptyResponse>?) {
        let target = AwesomeAdsTarget(environment, .event(query: query))
        responseHandler(target: target, completion: completion)
    }
    
    func performance(metric: PerformanceMetric, completion: OnResult<EmptyResponse>?) {
        let target = AwesomeAdsTarget(environment, .performance(metric: metric))
        responseHandler(target: target, completion: completion)
    }

    func featureFlags(query: QueryBundle, completion: @escaping OnResult<FeatureFlags>) {
        let target = AwesomeAdsTarget(environment, .featureFlags(query: query))
        responseHandler(target: target, completion: completion)
    }

    func globalFeatureFlags(completion: @escaping OnResult<GlobalFeatureFlags>) {
        let target = AwesomeAdsTarget(environment, .globalFeatureFlags)
        responseHandler(target: target, completion: completion)
    }

    private func responseHandler<T: Codable>(target: AwesomeAdsTarget, completion: OnResult<T>?) {
        var retries = 0
        let delay = retryDelay
        let innerLogger = logger

        func innerRequest() {
            provider.request(target) { result in
                switch result {
                case .success(let response):
                    do {
                        let filteredResponse = try response.filterSuccessfulStatusCodes()
                        let result = try filteredResponse.map(T.self, failsOnEmptyData: false)
                        completion?(Result.success(result))
                    } catch let error {
                        // If the server responds with a 4xx or 5xx error
                        completion?(Result.failure(error))
                    }
                case .failure(let error):
                    // This means there was a network failure
                    // - either the request wasn't sent (connectivity),
                    // - or no response was received (server timed out)
                    if retries < Constants.numberOfRetries {
                        innerLogger.error("Network failure, retrying again", error: error)
                        retries += 1
                        DispatchQueue.global().asyncAfter(deadline: .now() + delay) {
                            innerRequest()
                        }
                    } else {
                        innerLogger.error("Number of retries reached", error: error)
                        completion?(Result.failure(error))
                    }
                }
            }
        }

        innerRequest()
    }
}
