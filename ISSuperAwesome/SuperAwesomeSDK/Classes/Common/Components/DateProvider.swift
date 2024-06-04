//
//  DateProvider.swift
//  SuperAwesome
//
//  Created by Gunhan Sancar on 29/10/2020.
//

protocol DateProviderType {
    /// Returns the MMyyyy of the current date
    func nowAsMonthYear() -> String
}

class DateProvider: DateProviderType {
    func nowAsMonthYear() -> String { Date().monthYearString }
}
