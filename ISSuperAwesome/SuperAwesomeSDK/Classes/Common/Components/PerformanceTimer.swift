//
//  PerformanceTimer.swift
//  SuperAwesome
//
//  Created by Gunhan Sancar on 02/06/2023.
//

protocol PerformanceTimerType {
    /// Calculates the duration between starting of this timer and now
    /// - Returns the duration in milliseconds
    func calculate() -> Int64
}

class PerformanceTimer: PerformanceTimerType {
    private var startTime: TimeInterval = 0
    private let timeProvider: TimeProviderType
    
    init(timeProvider: TimeProviderType) {
        self.timeProvider = timeProvider
        self.startTime = timeProvider.secondsSince1970
    }
    
    func calculate() -> Int64 {
        let duration = timeProvider.secondsSince1970 - startTime
        return Int64((duration * 1000.0).rounded())
    }
}
