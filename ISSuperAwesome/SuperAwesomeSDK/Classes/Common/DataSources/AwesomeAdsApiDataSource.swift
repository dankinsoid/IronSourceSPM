//
//  AdDataSource.swift
//  SuperAwesome
//
//  Created by Gunhan Sancar on 23/04/2020.
//

/// `AwesomeAdsDataSource` is used to make request to `AwesomeAds` API
protocol AwesomeAdsApiDataSourceType {
    /// Makes a request to `/ad` endpoint to retrieve an Ad object for the given `placementId`
    func getAd(placementId: Int, query: QueryBundle, completion: @escaping OnResult<Ad>)

    /// Makes a request to `/ad/{placementId}/{lineItemId}/{creativeId}` endpoint to retrieve an Ad object for the given `placementId`
    func getAd(placementId: Int,
               lineItemId: Int,
               creativeId: Int,
               query: QueryBundle,
               completion: @escaping OnResult<Ad>)

    /// Makes a request to `/impression` endpoint to trigger an impression event
    func impression(query: QueryBundle, completion: OnResult<EmptyResponse>?)

    /// Makes a request to `/click` endpoint to trigger an click event
    func click(query: QueryBundle, completion: OnResult<EmptyResponse>?)

    /// Makes a request to `/video/click` endpoint to trigger an video click event
    func videoClick(query: QueryBundle, completion: OnResult<EmptyResponse>?)

    /// Makes a request to `/event` endpoint to trigger an custom event
    func event(query: QueryBundle, completion: OnResult<EmptyResponse>?)

    /// Makes a request to `/sdk/performance` endpoint to measure the various performance metrics
    func performance(metric: PerformanceMetric, completion: OnResult<EmptyResponse>?)

    /// Gets the feature flags from `/featureFlags` endpoint to toggle features on and off or configure parts of the SDK
    func featureFlags(query: QueryBundle, completion: @escaping OnResult<FeatureFlags>)

    /// Gets the global feature flags from `/featureFlags/ios/featureFlags.json` endpoint on S3 to toggle features on and off or configure parts of the SDK
    func globalFeatureFlags(completion: @escaping OnResult<GlobalFeatureFlags>)
}
