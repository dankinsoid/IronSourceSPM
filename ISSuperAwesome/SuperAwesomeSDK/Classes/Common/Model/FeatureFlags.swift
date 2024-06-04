//
//  FeatureFlags.swift
//  SuperAwesome
//
//  Created by Myles Eynon on 22/11/2023.
//

import Foundation

struct FeatureFlags: Codable, Equatable {
    let isAdResponseVASTEnabled: Bool

    static func == (lhs: FeatureFlags, rhs: FeatureFlags) -> Bool {
        lhs.isAdResponseVASTEnabled == rhs.isAdResponseVASTEnabled
    }
}
