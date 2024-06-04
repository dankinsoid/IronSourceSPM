//
//  AwesomeAdsSdk.swift
//  SuperAwesome
//
//  Created by Gunhan Sancar on 26/04/2020.
//

@objc(AwesomeAds)
public class AwesomeAds: NSObject {
    public static let shared = AwesomeAds()

    private(set) var container: DependencyContainer!
    private(set) var globalFeatureFlagsManager: GlobalFeatureFlagsManagerType!
    private var initialised: Bool = false

    private func registerDependencies(_ configuration: Configuration) {
        self.container = DependencyContainer()

        CommonModule(configuration: configuration).register(container)
        NetworkModule().register(container)
        UIModule().register(container)

        InjectableComponent.register(self.container)
    }

    /// Initialise the AwesomeAds SDK
    ///
    /// - Parameter configuration: to set various options including environment, and logging
    /// - Parameter completion: Callback closure to be notified once the initialisation is done
    @objc
    public func initSDK(configuration: Configuration = Configuration(),
                        completion: (() -> Void)? = nil) {
        guard !initialised else { return }
        registerDependencies(configuration)
        let globalFeatureFlagsManager: GlobalFeatureFlagsManagerType = container.resolve()
        self.globalFeatureFlagsManager = globalFeatureFlagsManager
        globalFeatureFlagsManager.loadGlobalFeatureFlags { _ in }
        initialised = true
        completion?()
    }

    /// Gets information about AwesomeAds SDK
    ///
    /// Returns `nil` if the AwesomeAds SDK has not been initialised
    @objc
    public func info() -> SdkInfoType? {
        guard initialised else { return nil }
        let info: SdkInfoType = container.resolve()
        return info
    }

    /// Gets information about AwesomeAds SDK
    ///
    /// Returns `nil` if the AwesomeAds SDK has not been initialised
    @objc
    public static func info() -> SdkInfoType? { shared.info() }

    /// Initialise the AwesomeAds SDK.
    ///
    /// - Parameter logging: enables or disables the logging of the SDK
    @objc
    public static func initSDK(_ logging: Bool) {
        shared.initSDK(configuration: Configuration(environment: .production, logging: logging), completion: nil)
    }

    /// Initialise the AwesomeAds SDK
    ///
    /// - Parameter configuration: to set various options including environment, and logging
    /// - Parameter completion: Callback closure to be notified once the initialisation is done
    @objc
    public static func initSDK(configuration: Configuration = Configuration(),
                               completion: (() -> Void)? = nil) {
        shared.initSDK(configuration: configuration, completion: completion)
    }
}
