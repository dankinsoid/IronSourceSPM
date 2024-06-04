//
//  GlobalFeatureFlags.swift
//  SuperAwesome
//
//  Created by Myles Eynon on 16/01/2024.
//

import Foundation

struct GlobalFeatureFlags: Codable, Equatable {
    let isAdResponseVASTEnabled: Bool

    init(isAdResponseVASTEnabled: Bool = false) {
        self.isAdResponseVASTEnabled = isAdResponseVASTEnabled
    }

    static func == (lhs: GlobalFeatureFlags, rhs: GlobalFeatureFlags) -> Bool {
        lhs.isAdResponseVASTEnabled == rhs.isAdResponseVASTEnabled
    }
}
