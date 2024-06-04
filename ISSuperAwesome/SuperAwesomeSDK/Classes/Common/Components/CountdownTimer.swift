//
//  FailSafeTimer.swift
//  SuperAwesome
//
//  Created by Myles Eynon on 10/10/2023.
//

import Foundation

protocol CountdownTimerType: AnyObject {
    func start()
    func pause()
    func stop()
}

internal class CountdownTimer: CountdownTimerType {

    private var timeInterval: TimeInterval = 15.0
    private var startTime: TimeInterval = 0
    private var timerHasFired: Bool = false
    private var completionBlock: () -> Void

    var timerDidFire: Bool {
        timerHasFired
    }

    private var timer: Timer?

    private var deductedTime: TimeInterval {
        Date().timeIntervalSince1970 - startTime
    }

    init(timeInterval: TimeInterval = 15.0, completion: @escaping () -> Void) {
        self.timeInterval = timeInterval
        self.completionBlock = completion
    }

    func start() {
        clearTimer()
        startTime = Date().timeIntervalSince1970
        guard timeInterval > 0 else { return }
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false, block: { [weak self] _ in
            self?.stop()
            self?.completionBlock()
        })
    }

    func pause() {
        clearTimer()
        timeInterval -= deductedTime
    }

    func stop() {
        timeInterval = 0.0
        clearTimer()
    }

    private func clearTimer() {
        timer?.invalidate()
        timer = nil
    }
}
