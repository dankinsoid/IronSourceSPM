//
//  SdkInfo.swift
//  SuperAwesome
//
//  Created by Gunhan Sancar on 17/04/2020.
//

@objc
public protocol SdkInfoType {
    /// Returns the combined version information platform + version number
    /// e.g. ios_x.y.z
    var version: String { get }

    /// Returns the version number only
    /// e.g. x.y.z
    var versionNumber: String { get }

    /// Returns the bundle name for the app
    var bundle: String { get }

    /// Returns the name of the app
    var name: String { get }

    /// Returns the preferred locale language and region
    /// e.g. en_UK
    var lang: String { get }
}

@objc
public class SdkInfo: NSObject, SdkInfoType {
    private static var overriddenVersion: String?

    let sdkVersion: String
    let pluginName: String
    public var bundle: String
    public var name: String
    public var lang: String
    public var versionNumber: String

    init(mainBundle: Bundle, locale: Locale, encoder: EncoderType) {
        self.versionNumber = SDK_VERSION
        self.bundle = mainBundle.bundleIdentifier ?? ""
        self.name = encoder.encodeUri(mainBundle.name)

        if let shortLang = mainBundle.preferredLocalizations.first,
           let region = locale.regionCode {
            self.lang = "\(shortLang)_\(region)"
        } else {
            self.lang = "none"
        }

        #if ADMOB_PLUGIN
        self.pluginName = "_admob"
        #else
        self.pluginName = ""
        #endif

        self.sdkVersion = "ios_\(versionNumber)"
    }

    public var version: String {
        return "\(SdkInfo.overriddenVersion ?? sdkVersion)\(pluginName)"
    }

    @objc
    public class func overrideVersion(_ version: String?, withPlatform platform: String?) {
        if let platform = platform, let version = version {
            SdkInfo.overriddenVersion = "\(platform)_\(version)"
        } else {
            SdkInfo.overriddenVersion = nil
        }
    }
}
