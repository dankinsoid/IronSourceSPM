//
//  VideoCache.swift
//  SuperAwesome
//
//  Created by Myles Eynon on 17/11/2023.
//

import Foundation

/// Provides caching for videos.
protocol VideoCacheType {

     /// Gets a video in the cache, if it doesn't exist, it will be downloaded.
     ///
     /// - parameter url The remote path of the video file.
     /// - parameter completion the completion block with the local file url as a parameter.
    func get(url: String, completion: @escaping (String?) -> Void)

    /// Cleans up the cache, following the cache expiration policy.
    func cleanUp()
}

/// Policies for caching video.
protocol VideoCachePolicyType {
    /// Duration of the cache.
    var duration: TimeInterval { get }
}

/// No caching, all videos will be deleted.
struct NoCaching : VideoCachePolicyType {
    let duration: TimeInterval = 0
}

/// Default Caching policy
struct MaxAge : VideoCachePolicyType {
    let duration: TimeInterval

    init(duration: TimeInterval = 1_000 * 60 * 60 * 24 * 7) { // 1 Week
        self.duration = duration
    }
}

/// Default implementation of [VideoCache].
class VideoCache : VideoCacheType {

    private let preferences: PreferencesRepositoryType
    private let remoteDataSource: NetworkDataSourceType
    private let logger: LoggerType
    private let timeProvider: TimeProviderType
    private let policy: VideoCachePolicyType

    init(preferences: PreferencesRepositoryType,
         remoteDataSource: NetworkDataSourceType,
         logger: LoggerType,
         timeProvider: TimeProviderType,
         policy: VideoCachePolicyType = MaxAge()) {

        self.preferences = preferences
        self.remoteDataSource = remoteDataSource
        self.logger = logger
        self.timeProvider = timeProvider
        self.policy = policy

        cleanUp()
    }

    func get(url: String, completion: @escaping (String?) -> Void) {
        guard let storedVideo = preferences.getVideo(forUrl: url) else {
            cache(url: url, completion: completion)
            return
        }
        let jsonDecoder = JSONDecoder()
        guard let storedVideoData = storedVideo.data(using: .utf8),
              let cachedVideo = try? jsonDecoder.decode(CacheEntry.self, from: storedVideoData) else {
            completion(nil)
            return
        }
        completion(cachedVideo.path)
    }

    private func cache(url: String, completion: @escaping (String?) -> Void) {
        remoteDataSource.downloadFile(url: url) { [weak self] result in
            switch result {
            case .success(let localFilePath):
                if (self?.policy is MaxAge) {
                    let entry = CacheEntry(path: localFilePath, timestamp: self?.timeProvider.secondsSince1970 ?? 0.0)
                    let jsonEncoder = JSONEncoder()
                    if let jsonData = try? jsonEncoder.encode(entry) {
                        let json = String(data: jsonData, encoding: String.Encoding.utf8)
                        self?.preferences.putVideo(forUrl: entry.path, video: json)
                    }
                }
                completion(localFilePath)
            case .failure(let error):
                self?.logger.error("Error downloading file", error: error)
                completion(nil)
            }
        }
    }

    func cleanUp() {
        let now = timeProvider.secondsSince1970
        let jsonDecoder = JSONDecoder()
        let expired: [CacheEntry] = preferences.getAllVideos().compactMap {
            guard let storedVideoData = $0.data(using: .utf8) else { return nil }
            return try? jsonDecoder.decode(CacheEntry.self, from: storedVideoData)
        }.filter { now - $0.timestamp > policy.duration }
        
        expired.forEach { entry in
            guard let fileUrl = URL(string: entry.path) else { return }
            do {
                try FileManager.default.removeItem(atPath: fileUrl.path)
                preferences.putVideo(forUrl: entry.path, video: nil)
            } catch(let error) {
                logger.error("File \(entry.path) couldn't be deleted", error: error)
            }
        }
    }

    private struct CacheEntry : Codable {
        let path: String
        let timestamp: TimeInterval
    }
}
