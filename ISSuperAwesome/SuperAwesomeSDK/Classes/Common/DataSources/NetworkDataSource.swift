//
//  NetworkDataSource.swift
//  SuperAwesome
//
//  Created by Gunhan Sancar on 08/07/2020.
//

/// `NetworkDataSource` is used to make generic networking operations
protocol NetworkDataSourceType {
    /// Makes the `GET` request and returns the raw data in a `Data`object
    func getData(url: String, completion: OnResult<Data>?)

    /// Downloads the file on the given `url` and saves  locally, Then returns the `path` of the local file
    func downloadFile(url: String, completion: @escaping OnResult<String>)

    /// Clears the files from the user's document directory which is downloaded by itself
    func clearFiles()
}
