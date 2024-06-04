//
//  FeatureFlagsQuery.swift
//  SuperAwesome
//
//  Created by Myles Eynon on 30/11/2023.
//

import Foundation

struct FeatureFlagsQuery: Codable {
    let placementId: Int
    let bundle: String
    let lineItemId: Int?
    let creativeId: Int?
    let connectionType: ConnectionType
    let sdkVersion: String
    let device: String

    enum CodingKeys: String, CodingKey {
        case placementId = "placement"
        case bundle
        case lineItemId = "line_item"
        case creativeId = "creative"
        case connectionType = "ct"
        case sdkVersion
        case device
    }
}

