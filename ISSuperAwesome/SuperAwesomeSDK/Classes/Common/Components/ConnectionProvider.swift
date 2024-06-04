//
//  ConnectionProvider.swift
//  SuperAwesome
//
//  Created by Gunhan Sancar on 17/04/2020.
//

import Foundation
import SystemConfiguration
import CoreTelephony

protocol ConnectionProviderType {
    func findConnectionType() -> ConnectionType
}

class ConnectionProvider: ConnectionProviderType {
    func findConnectionType() -> ConnectionType {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)

        guard let reachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return .unknown
        }

        var flags = SCNetworkReachabilityFlags()

        if !SCNetworkReachabilityGetFlags(reachability, &flags) {
            return .unknown
        }

        if !flags.contains(.reachable) {
            return .unknown
        } else if flags.contains(.isWWAN) {
            return getCellularType()
        } else if !flags.contains(.connectionRequired) {
            return .wifi
        } else if (flags.contains(.connectionOnDemand) || flags.contains(.connectionOnTraffic))
                    && !flags.contains(.interventionRequired) {
            return .wifi
        }

        return .unknown
    }

    private func getCellularType() -> ConnectionType {
        let networkInfo = CTTelephonyNetworkInfo()

        var networkString: String?
        if #available(iOS 12.0, *) {
            networkString = networkInfo.serviceCurrentRadioAccessTechnology?.first?.value
        } else {
            networkString = networkInfo.currentRadioAccessTechnology
        }
        if #available(iOS 14.1, *) {
            if networkString == CTRadioAccessTechnologyNRNSA || networkString == CTRadioAccessTechnologyNR {
                return .cellular5g
            }
        }

        switch networkString {
        case CTRadioAccessTechnologyLTE:
            return .cellular4g
        case CTRadioAccessTechnologyCDMA1x,
            CTRadioAccessTechnologyCDMAEVDORev0,
            CTRadioAccessTechnologyCDMAEVDORevA,
            CTRadioAccessTechnologyCDMAEVDORevB,
            CTRadioAccessTechnologyeHRPD,
            CTRadioAccessTechnologyHSDPA,
            CTRadioAccessTechnologyHSUPA,
        CTRadioAccessTechnologyWCDMA:
            return .cellular3g
        case CTRadioAccessTechnologyEdge,
        CTRadioAccessTechnologyGPRS:
            return .cellular2g
        default:
            return .cellularUnknown
        }
    }
}
