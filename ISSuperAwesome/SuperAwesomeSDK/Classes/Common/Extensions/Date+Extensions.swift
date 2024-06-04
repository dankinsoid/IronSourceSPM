//
//  Date+Extensions.swift
//  SuperAwesome
//
//  Created by Gunhan Sancar on 29/10/2020.
//

import Foundation

extension Date {
    fileprivate static let monthYearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMyyyy"
        return formatter
    }()

    /// Convert this date instance to MMyyyy formatted String
    var monthYearString: String { Date.monthYearFormatter.string(from: self) }
}
