//
//  MoyaPluginRegistrar.swift
//  SuperAwesome
//
//  Created by Gunhan Sancar on 27/04/2020.
//

import Moya

class NetworkModule: DependencyModule {
    func register(_ container: DependencyContainer) {
        container.factory(MoyaLoggerPlugin.self) { cont, _ in
            MoyaLoggerPlugin(logger: cont.resolve(param: MoyaLoggerPlugin.self) as LoggerType)
        }
        container.factory(MoyaHeaderPlugin.self) { cont, _ in
            MoyaHeaderPlugin(userAgentProvider: cont.resolve() as UserAgentProviderType)
        }
        container.single(MoyaProvider<AwesomeAdsTarget>.self) { cont, _ in
            let configuration = URLSessionConfiguration.default
            configuration.headers = .default
            configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
            let session = Session(configuration: configuration, startRequestsImmediately: false)
            return MoyaProvider<AwesomeAdsTarget>(session: session,
                                                  plugins: [cont.resolve() as MoyaHeaderPlugin,
                                                            cont.resolve() as MoyaLoggerPlugin])
        }
        container.single(AwesomeAdsApiDataSourceType.self) { cont, _ in
            MoyaAwesomeAdsApiDataSource(provider: cont.resolve(),
                                        environment: cont.resolve(),
                                        retryDelay: Constants.retryDelay,
                                        logger: cont.resolve(param: MoyaAwesomeAdsApiDataSource.self) as LoggerType)
        }
        container.single(NetworkDataSourceType.self) { _, _ in
            AFNetworkDataSource()
        }
    }
}
