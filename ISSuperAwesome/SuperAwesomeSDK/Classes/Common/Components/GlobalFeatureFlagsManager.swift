//
//  GlobalFeatureFlagsManager.swift
//  SuperAwesome
//
//  Created by Myles Eynon on 16/01/2024.
//

import Foundation

protocol GlobalFeatureFlagsManagerType {
    var globalFeatureFlags: GlobalFeatureFlags? { get }

    func loadGlobalFeatureFlags(completion: @escaping (GlobalFeatureFlags?) -> Void)
}

class GlobalFeatureFlagsManager: GlobalFeatureFlagsManagerType {
    var globalFeatureFlags: GlobalFeatureFlags? = GlobalFeatureFlags()

    private var featureFlagsRepository: GlobalFeatureFlagsRepositoryType
    private var logger: LoggerType

    init(globalFeatureFlagsRepository: GlobalFeatureFlagsRepositoryType,
         logger: LoggerType) {
        self.featureFlagsRepository = globalFeatureFlagsRepository
        self.logger = logger
    }

    func loadGlobalFeatureFlags(completion: @escaping (GlobalFeatureFlags?) -> Void) {
        featureFlagsRepository.fetchGlobalFeatureFlags { [weak self] result in
            switch result {
            case .success(let featureFlags):
                self?.globalFeatureFlags = featureFlags
            case .failure(let error):
                self?.logger.error("Failed to get remote global feature flags", error: error)
            }
            completion(self?.globalFeatureFlags)
        }
    }
}
