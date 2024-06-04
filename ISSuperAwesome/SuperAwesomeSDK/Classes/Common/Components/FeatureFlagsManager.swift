//
//  FeatureFlagsManager.swift
//  SuperAwesome
//
//  Created by Myles Eynon on 30/11/2023.
//

import Foundation

protocol FeatureFlagsManagerType {
    var featureFlags: FeatureFlags? { get }

    func loadFeatureFlags(forPlacementId placementId: Int,
                          lineItemId: Int?,
                          creativeId: Int?,
                          completion: @escaping (FeatureFlags?) -> Void)
}

class FeatureFlagsManager: FeatureFlagsManagerType {
    var featureFlags: FeatureFlags?

    private var featureFlagsRepository: FeatureFlagsRepositoryType
    private var logger: LoggerType

    init(featureFlagsRepository: FeatureFlagsRepositoryType,
         logger: LoggerType) {
        self.featureFlagsRepository = featureFlagsRepository
        self.logger = logger
    }

    func loadFeatureFlags(forPlacementId placementId: Int,
                          lineItemId: Int?,
                          creativeId: Int?,
                          completion: @escaping (FeatureFlags?) -> Void) {
        featureFlagsRepository.fetchFeatureFlags(placementId: placementId,
                                                 lineItemId: lineItemId,
                                                 creativeId: creativeId) { [weak self] result in
            switch result {
            case .success(let featureFlags):
                self?.featureFlags = featureFlags
            case .failure(let error):
                self?.logger.error("Failed to get remote feature flags for placementId: \(placementId)", error: error)
            }
            completion(self?.featureFlags)
        }
    }
}
