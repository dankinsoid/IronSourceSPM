//
//  GlobalFeatureFlagsRepository.swift
//  SuperAwesome
//
//  Created by Myles Eynon on 16/01/2024.
//

import Foundation

protocol GlobalFeatureFlagsRepositoryType {
    func fetchGlobalFeatureFlags(completion: @escaping OnResult<GlobalFeatureFlags>)
}

class GlobalFeatureFlagsRepository: GlobalFeatureFlagsRepositoryType {

    private let dataSource: AwesomeAdsApiDataSourceType

    init(dataSource: AwesomeAdsApiDataSourceType) {
        self.dataSource = dataSource
    }

    func fetchGlobalFeatureFlags(completion: @escaping OnResult<GlobalFeatureFlags>) {
        dataSource.globalFeatureFlags { result in
            switch result {
            case .success(let featureFlags):
                completion(Result.success(featureFlags))
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
}
