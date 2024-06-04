//
//  AFNetworkDataSource.swift
//  SuperAwesome
//
//  Created by Gunhan Sancar on 08/07/2020.
//

import Alamofire

class AFNetworkDataSource: NetworkDataSourceType {

    private lazy var networking: Session = {
        let sessionConfig = URLSessionConfiguration.af.default
        sessionConfig.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        return Session.init(configuration: sessionConfig)
    }()

    func getData(url: String, completion: OnResult<Data>?) {

        guard let cleanUrl = url.removingPercentEncoding?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            completion?(Result.failure(AwesomeAdsError.network))
            return
        }

        networking.request(cleanUrl, method: .get).responseData { response in
            guard let data = response.data else {
                completion?(Result.failure(AwesomeAdsError.network))
                return
            }
            completion?(Result.success(data))
        }
    }

    func downloadFile(url: String, completion: @escaping OnResult<String>) {
        // The url should contain the file extension at the end
        guard let fileExtension = url.fileExtension else {
            completion(Result.failure(AwesomeAdsError.fileInvalid))
            return
        }

        let fileName =  "\(url.toMD5).\(fileExtension)"

        let destination: DownloadRequest.Destination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent(fileName)

            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }

        networking.download(url, to: destination).response { response in
            debugPrint(response)

            if response.error == nil, let path = response.fileURL?.path {
                completion(Result.success(path))
            } else {
                completion(Result.failure(AwesomeAdsError.network))
            }
        }
    }

    func clearFiles() {
        do {
            let fileManager = FileManager.default
            let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
            try fileManager.removeItem(at: documentsURL)
        } catch {
            return
        }
    }
}
