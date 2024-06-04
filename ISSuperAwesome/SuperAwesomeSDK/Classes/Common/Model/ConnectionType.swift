//
//  ConnectionType.swift
//  SuperAwesome
//
//  Created by Gunhan Sancar on 17/04/2020.
//

/// Possible network connection types
enum ConnectionType: Int, Codable {
    case unknown = 0
    case ethernet = 1
    case wifi = 2
    case cellularUnknown = 3
    case cellular2g = 4
    case cellular3g = 5
    case cellular4g = 6
    case cellular5g = 7
}

/// Represent connection quality
/// For 2g connections minimum
/// For 3g connections medium
/// For 4g, wifi connections maximum
enum ConnectionQuality: Int, Codable {
    case minumum = 0
    case medium = 1
    case maximum = 2
}

extension ConnectionType {
    func findQuality() -> ConnectionQuality {
        switch self {
        case .cellular2g, .cellularUnknown: return .minumum
        case .unknown, .ethernet, .cellular4g, .cellular5g, .wifi: return .maximum
        default: return .medium
        }
    }
}
