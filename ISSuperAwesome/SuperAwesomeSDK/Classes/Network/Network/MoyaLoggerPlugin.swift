//
//  MoyaLoggerPlugin.swift
//  SuperAwesome
//
//  Created by Gunhan Sancar on 02/02/2022.
//

import Moya

struct MoyaLoggerPlugin: PluginType {
    private let logger: LoggerType

    init(logger: LoggerType) {
        self.logger = logger
    }

    func willSend(_ request: RequestType, target: TargetType) {
        let httpMethod = request.request?.httpMethod ?? ""
        let url = request.request?.url?.absoluteString ?? ""
        logger.info("\(httpMethod) \(url)")
    }

    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        switch result {
        case .success(let response):
            let statusCode = response.statusCode
            let url = response.request?.url?.absoluteString ?? ""
            let body = String(data: response.data, encoding: .utf8) ?? ""
            let message = "Status: \(statusCode) URL: \(url)\nBody: \(body)"

            if 200 ... 299 ~= statusCode {
                logger.success(message)
            } else {
                let error = NSError(domain: "", code: statusCode, userInfo: [ NSLocalizedDescriptionKey: message])
                logger.error("Error", error: error)
            }
        case let .failure(error):
            logger.error("Network request error", error: error)
        }
    }
}
