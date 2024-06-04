//
//  FeatureFlagsRepository.swift
//  SuperAwesome
//
//  Created by Myles Eynon on 30/11/2023.
//

import Foundation

protocol FeatureFlagsRepositoryType {
    func fetchFeatureFlags(placementId: Int,
                           lineItemId: Int?,
                           creativeId: Int?,
                           completion: @escaping OnResult<FeatureFlags>)
}

class FeatureFlagsRepository: FeatureFlagsRepositoryType {

    private let dataSource: AwesomeAdsApiDataSourceType
    private let adQueryMaker: AdQueryMakerType

    init(dataSource: AwesomeAdsApiDataSourceType,
         adQueryMaker: AdQueryMakerType) {
        self.dataSource = dataSource
        self.adQueryMaker = adQueryMaker
    }

    func fetchFeatureFlags(placementId: Int,
                           lineItemId: Int?,
                           creativeId: Int?,
                           completion: @escaping OnResult<FeatureFlags>) {
        let query = adQueryMaker.makeFeatureFlagsQuery(placementId: placementId,
                                                       lineItemId: lineItemId,
                                                       creativeId: creativeId)
        dataSource.featureFlags(query: query) { result in
            switch result {
            case .success(let featureFlags):
                completion(Result.success(featureFlags))
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
}
