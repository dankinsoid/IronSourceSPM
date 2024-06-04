//
//  CommonModule.swift
//  SuperAwesome
//
//  Created by Gunhan Sancar on 03/11/2020.
//

struct CommonModule: DependencyModule {

    let configuration: Configuration

    func register(_ container: DependencyContainer) {
        registerComponentModule(container)
        registerRepositoryModule(container)
    }

    private func registerComponentModule(_ container: DependencyContainer) {
        container.single(Bundle.self) { _, _  in Bundle.main }
        container.single(StringProviderType.self) { _, _  in StringProvider() }
        container.factory(LoggerType.self) { _, param in
            OsLogger(configuration.logging, "\(param[0] ?? "")") }
        container.single(Environment.self) { _, _ in configuration.environment }
        container.single(ConnectionProviderType.self) { _, _ in ConnectionProvider() }
        container.single(DeviceType.self) { _, _ in Device(UIDevice.current) }
        container.single(EncoderType.self) { _, _ in CustomEncoder() }
        container.single(PreferencesType.self) { _, _ in Preferences(preferences: UserDefaults.standard) }
        container.single(IdGeneratorType.self) { container, _ in
            IdGenerator(preferencesRepository: container.resolve(),
                        sdkInfo: container.resolve(),
                        numberGenerator: container.resolve(),
                        dateProvider: container.resolve())
        }
        container.single(NumberGeneratorType.self) { _, _ in NumberGenerator() }
        container.single(SdkInfoType.self) { container, _ in
            SdkInfo(mainBundle: container.resolve(),
                    locale: Locale.current,
                    encoder: container.resolve())
        }
        container.single(UserAgentProviderType.self) { container, _ in
            UserAgentProvider(device: container.resolve(), preferencesRepository: container.resolve())
        }
        container.single(AdQueryMakerType.self) { container, _ in
            AdQueryMaker(device: container.resolve(),
                         sdkInfo: container.resolve(),
                         connectionProvider: container.resolve(),
                         numberGenerator: container.resolve(),
                         idGenerator: container.resolve(),
                         encoder: container.resolve(),
                         options: configuration.options)
        }
        container.single(FeatureFlagsManagerType.self) { container, _ in
            FeatureFlagsManager(featureFlagsRepository: container.resolve(),
                                logger: container.resolve(param: FeatureFlagsManager.self))
        }
        container.single(GlobalFeatureFlagsManagerType.self) { container, _ in
            GlobalFeatureFlagsManager(globalFeatureFlagsRepository: container.resolve(),
                                      logger: container.resolve(param: GlobalFeatureFlagsManager.self))
        }
        container.single(VastParserType.self) { container, _ in
            VastParser(connectionProvider: container.resolve())
        }
        container.single(VideoCacheType.self) { container, _ in
            VideoCache(preferences: container.resolve(),
                       remoteDataSource: container.resolve(),
                       logger: container.resolve(param: VideoCache.self),
                       timeProvider: container.resolve())
        }
        container.single(AdProcessorType.self) { container, _ in
            AdProcessor(htmlFormatter: container.resolve(),
                        vastParser: container.resolve(),
                        networkDataSource: container.resolve(),
                        videoCache: container.resolve(),
                        logger: container.resolve(param: AdProcessor.self))
        }
        container.single(HtmlFormatterType.self) { container, _ in
            HtmlFormatter(numberGenerator: container.resolve(), encoder: container.resolve())
        }
        container.single(ImageProviderType.self) { _, _ in ImageProvider() }
        container.single(OrientationProviderType.self) { container, _ in OrientationProvider(container.resolve()) }
        container.single(DateProviderType.self) { _, _ in  DateProvider() }
        container.single(TimeProviderType.self) { _, _ in  TimeProvider() }
    }

    private func registerRepositoryModule(_ container: DependencyContainer) {
        container.single(PreferencesRepositoryType.self) { _, _ in
            PreferencesRepository(preferences: container.resolve())
        }
        container.single(AdRepositoryType.self) { container, _ in
            AdRepository(dataSource: container.resolve(),
                         adQueryMaker: container.resolve(),
                         adProcessor: container.resolve())
        }
        container.single(EventRepositoryType.self) { container, _ in
            EventRepository(dataSource: container.resolve(),
                            adQueryMaker: container.resolve(),
                            logger: container.resolve(param: EventRepository.self))
        }
        container.factory(VastEventRepositoryType.self) { container, param in
            guard let adResponse = param[0] as?  AdResponse else {
                fatalError()
            }
            return VastEventRepository(adResponse: adResponse,
                                networkDataSource: container.resolve(),
                                logger: container.resolve(param: VastEventRepository.self))
        }
        container.single(PerformanceRepositoryType.self) { container, _ in
            PerformanceRepository(dataSource: container.resolve(),
                            logger: container.resolve(param: PerformanceRepository.self))
        }
        container.single(FeatureFlagsRepositoryType.self) { container, _ in
            FeatureFlagsRepository(dataSource: container.resolve(),
                                   adQueryMaker: container.resolve())
        }
        container.single(GlobalFeatureFlagsRepositoryType.self) { container, _ in
            GlobalFeatureFlagsRepository(dataSource: container.resolve())
        }
    }
}
