//
//  Logger.swift
//  SuperAwesome
//
//  Created by Gunhan Sancar on 27/08/2020.
//

import os

protocol LoggerType {
    func info(_ message: String)
    func info(_ message: String, depth: Int)
    func success(_ message: String)
    func error(_ message: String, error: Error)
    func tag(_ tag: String) -> LoggerType
}

public class OsLogger: LoggerType {
    private var tag: String = ""
    private let prefix: String = ""
    private let loggingEnabled: Bool

    init(_ loggingEnabled: Bool, _ tag: String?) {
        self.loggingEnabled = loggingEnabled
        self.tag = tag ?? self.tag
    }

    func tag(_ tag: String) -> LoggerType {
        self.tag = tag
        return self
    }

    func info(_ message: String) {
        guard loggingEnabled else { return }

        info(message, depth: 0)
    }

    func info(_ message: String, depth: Int) {
        guard loggingEnabled else { return }

        let depthString = String(repeating: "→ ", count: depth)
        os_log("%@", log: OSLog.default, type: OSLogType.info, "⬜️ [\(prefix)] \(depthString)[\(tag)] \(message)")
    }

    public func success(_ message: String) {
        guard loggingEnabled else { return }

        os_log("%@", log: OSLog.default, type: OSLogType.info, "🟩 [\(prefix)] [\(tag)] \(message)")
    }

    func error(_ message: String, error: Error) {
        guard loggingEnabled else { return }

        os_log("%@", log: OSLog.default, type: OSLogType.error, "🟥 [\(prefix)] [\(tag)] \(message) \n \(error.localizedDescription)")
    }
}
