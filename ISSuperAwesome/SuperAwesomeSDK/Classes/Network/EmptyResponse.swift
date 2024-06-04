//
//  EmptyResponse.swift
//  SuperAwesome
//
//  Created by Myles Eynon on 27/11/2023.
//

import Foundation

struct EmptyResponse: Codable {

    init() {}

    init(from decoder: Decoder) throws {
        return
    }
}
