//
//  QueryBundle.swift
//  SuperAwesome
//
//  Created by Gunhan Sancar on 31/05/2022.
//

struct QueryBundle {
    let parameters: Codable
    let options: [String: Any]?

    /// Build query parameters by joining default `parameters` and `options`
    func build() -> [String: Any] {
        let query = parameters.toDictionary()
        if let options = options {
            return query.merging(options) { $1 }
        }
        return query
    }
}
