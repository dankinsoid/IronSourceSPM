//
//  TimeProvider.swift
//  SuperAwesome
//
//  Created by Gunhan Sancar on 19/10/2022.
//

import Foundation

protocol TimeProviderType {
    /// Returns the `TimeInterval` between now and 1970 in seconds
    var secondsSince1970: TimeInterval { get }
}

class TimeProvider: TimeProviderType {
    var secondsSince1970: TimeInterval {
        NSDate().timeIntervalSince1970
    }
}
