//
//  LocalDataPersistance.swift
//  SuperAwesome
//
//  Created by Gunhan Sancar on 03/04/2020.
//

import Foundation

protocol PreferencesRepositoryType {
    var userAgent: String? { get set }
    var dauUniquePart: String? { get set }

    func getVideo(forUrl url: String) -> String?
    func putVideo(forUrl url: String, video: String?)
    func getAllVideos() -> [String]
}

class PreferencesRepository: PreferencesRepositoryType {
    struct Keys {
        internal static let userAgent = "AwesomeAds.PreferencesRepository.Keys.userAgent"
        internal static let dauUniqueId = "AwesomeAds.PreferencesRepository.Keys.dauUniquePart"
        internal static let videoPrefix = "AwesomeAds.PreferencesRepository.Video."
    }

    private let preferences: PreferencesType

    init(preferences: PreferencesType) {
        self.preferences = preferences
    }

    public var userAgent: String? {
        get { preferences.string(forKey: Keys.userAgent) }
        set(newValue) { preferences.setString(newValue, forKey: Keys.userAgent) }
    }

    public var dauUniquePart: String? {
        get { preferences.string(forKey: Keys.dauUniqueId) }
        set(newValue) { preferences.setString(newValue, forKey: Keys.dauUniqueId) }
    }

    public func getVideo(forUrl url: String) -> String? {
        preferences.string(forKey: Keys.videoPrefix + url)
    }

    public func putVideo(forUrl url: String, video: String?) {
        preferences.setString(video, forKey: Keys.videoPrefix + url)
    }

    public func getAllVideos() -> [String] {
        preferences.getAllPreferences().compactMap {
            if ($0.key.contains(Keys.videoPrefix)) { return $0.value as? String }
            return nil
        }
    }
}
