//
//  Device.swift
//  SuperAwesome
//
//  Created by Gunhan Sancar on 02/04/2020.
//

import Foundation

protocol DeviceType {
    var type: String { get }
    var genericType: String { get }
    var systemVersion: String { get }
    var systemVersionEscaped: String { get }
    var userAgent: String { get }
}

class Device: DeviceType {
    public var type: String
    public var genericType: String
    public var systemVersion: String
    public var systemVersionEscaped: String
    public var userAgent: String

    init(_ device: UIDevice) {
        type = device.model.hasPrefix("iPad") ? "iPad" : "iPhone"
        genericType = type == "iPad" ? "tablet" : "phone"
        systemVersion = device.systemVersion
        systemVersionEscaped = systemVersion.replacingOccurrences(of: ".", with: "_")
        userAgent = "Mozilla/5.0 (\(type); CPU \(type) OS \(systemVersionEscaped) like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148"
    }
}
