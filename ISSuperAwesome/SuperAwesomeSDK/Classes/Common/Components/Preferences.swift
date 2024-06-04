//
//  Preferences.swift
//  SuperAwesome
//
//  Created by Myles Eynon on 22/11/2023.
//

import Foundation

protocol PreferencesType {
    func string(forKey key: String) -> String?
    func setString(_ value: String?, forKey key: String)
    func getAllPreferences() -> [String: Any]
}

class Preferences: PreferencesType {

    private var preferences: UserDefaults!

    init(preferences: UserDefaults) {
        self.preferences = preferences
    }

    func string(forKey key: String) -> String? {
        preferences.string(forKey: key)
    }

    func setString(_ value: String?, forKey key: String) {
        guard let value = value else {
            preferences.removeObject(forKey: key)
            return
        }
        preferences.set(value, forKey: key)
    }

    func getAllPreferences() -> [String: Any] {
        preferences.dictionaryRepresentation()
    }
}
