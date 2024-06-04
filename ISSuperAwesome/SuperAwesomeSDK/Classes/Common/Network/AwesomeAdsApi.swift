//
//  AwesomeAdsApi.swift
//  SuperAwesome
//
//  Created by Gunhan Sancar on 08/04/2020.
//

enum AwesomeAdsApi {
    case ad(placementId: Int, query: QueryBundle)
    case adByPlacementLineAndCreativeId(placementId: Int, lineItemId: Int, creativeId: Int, query: QueryBundle)
    case impression(query: QueryBundle)
    case click(query: QueryBundle)
    case videoClick(query: QueryBundle)
    case event(query: QueryBundle)
    case performance(metric: PerformanceMetric)
    case featureFlags(query: QueryBundle)
    case globalFeatureFlags

    var path: String {
        switch self {
        case .ad(let placementId, _):
            return "/ad/\(placementId)"
        case .adByPlacementLineAndCreativeId(
            placementId: let placementId,
            lineItemId: let lineItemId,
            creativeId: let creativeId, _):
            return "/ad/\(placementId)/\(lineItemId)/\(creativeId)"
        case .impression:
            return "/impression"
        case .click:
            return "/click"
        case .videoClick:
            return "/video/click"
        case .event:
            return "/event"
        case .performance:
            return "/sdk/performance"
        case .featureFlags:
            return "/featureFlags/featureFlags.json"
        case .globalFeatureFlags:
            return "/featureFlags/ios/featureFlags.json"
        }
    }
}
