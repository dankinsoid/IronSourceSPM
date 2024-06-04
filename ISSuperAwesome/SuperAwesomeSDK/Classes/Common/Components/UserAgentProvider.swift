//
//  UserAgentProvider.swift
//  SuperAwesome
//
//  Created by Gunhan Sancar on 01/04/2020.
//

import WebKit

/**
* Class that provides the current User Agent using WKWebView object.
*/
protocol UserAgentProviderType {
    var name: String { get }
}

class UserAgentProvider: UserAgentProviderType {
    public var name: String
    private var webView: WKWebView?
    private var preferencesRepository: PreferencesRepositoryType

    init(device: DeviceType, preferencesRepository: PreferencesRepositoryType) {
        self.preferencesRepository = preferencesRepository
        self.name = preferencesRepository.userAgent ?? device.userAgent
        evaluateUserAgent()
    }

    private func evaluateUserAgent() {
        let config = WKWebViewConfiguration()
        if #available(iOS 13.0, *) {
            let preferences = WKWebpagePreferences()
            preferences.preferredContentMode = .mobile
            config.defaultWebpagePreferences = preferences
        }
        webView = WKWebView(frame: .zero, configuration: config)
        webView?.evaluateJavaScript("navigator.userAgent", completionHandler: { [weak self] result, error in
            if error != nil {
                print("UserAgent.evaluateUserAgent.error:", String(describing: error))
            } else if let res = result as? String {
                self?.name = res
                self?.preferencesRepository.userAgent = res
            }
            self?.webView = nil
        })
    }
}
