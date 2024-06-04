//
//  Error.swift
//  SuperAwesome
//
//  Created by Gunhan Sancar on 08/07/2020.
//

enum AwesomeAdsError {
    case network
    case fileInvalid
    case missingVastOrTag
}

extension AwesomeAdsError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .network: return "Network error"
        case .fileInvalid: return "File error: Invalid format"
        case .missingVastOrTag: return "Missing VAST or Tag parameter in ad response"
        }
    }
}
