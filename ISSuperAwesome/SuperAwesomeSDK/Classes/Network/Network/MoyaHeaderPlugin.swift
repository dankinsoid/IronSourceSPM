//
//  MoyaHeaderPlugin.swift
//  SuperAwesome
//
//  Created by Gunhan Sancar on 08/04/2020.
//

import Moya

struct MoyaHeaderPlugin: PluginType {
    private let userAgentProvider: UserAgentProviderType

    init(userAgentProvider: UserAgentProviderType) {
        self.userAgentProvider = userAgentProvider
    }

    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        request.setValue(userAgentProvider.name, forHTTPHeaderField: "User-Agent")
        return request
    }
}
