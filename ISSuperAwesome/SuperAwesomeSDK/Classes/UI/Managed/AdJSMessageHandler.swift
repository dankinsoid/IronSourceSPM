//
//  AdJSMessageHandler.swift
//  SuperAwesome
//
//  Created by Myles Eynon on 05/04/2023.
//

import WebKit

protocol AdJSMessageHandlerDelegate: AnyObject {
    func onEvent(event: AdEvent)
}

class AdJSMessageHandler: NSObject, WKScriptMessageHandler {

    // MARK: Constants

    internal static let bridgeKey = "bridge"

    // MARK: Properties

    weak var delegate: AdJSMessageHandlerDelegate?

    // MARK: Init
    init(withWebViewConfiguration config: WKWebViewConfiguration) {
        super.init()
        addUserScript(withWebViewConfiguration: config)
        config.userContentController.add(self, name: AdJSMessageHandler.bridgeKey)
    }

    // MARK: Methods

    internal func addUserScript(withWebViewConfiguration config: WKWebViewConfiguration) {
        let script = WKUserScript(source: bridgeScript,
                                  injectionTime: .atDocumentStart,
                                  forMainFrameOnly: false)
        config.userContentController.addUserScript(script)
    }

    // MARK: WKScriptMessageHandler

    func userContentController(_ userContentController: WKUserContentController,
                               didReceive message: WKScriptMessage) {

        let body = String(describing: message.body)
        guard let id = Int(body), let event = AdEvent(rawValue: id) else { return }
        delegate?.onEvent(event: event)
    }

    private let bridgeScript = """
        function postMessageToBridge(message) {
            window.webkit.messageHandlers.bridge.postMessage(message);
        }

        var SA_AD_JS_BRIDGE = {
            adLoaded: function() { postMessageToBridge("\(AdEvent.adLoaded.rawValue)"); },
            adEmpty: function() { postMessageToBridge("\(AdEvent.adEmpty.rawValue)"); },
            adFailedToLoad: function() { postMessageToBridge("\(AdEvent.adFailedToLoad.rawValue)"); },
            adAlreadyLoaded: function() { postMessageToBridge("\(AdEvent.adAlreadyLoaded.rawValue)"); },
            adShown: function() { postMessageToBridge("\(AdEvent.adShown.rawValue)"); },
            adFailedToShow: function() { postMessageToBridge("\(AdEvent.adFailedToShow.rawValue)"); },
            adClicked: function() { postMessageToBridge("\(AdEvent.adClicked.rawValue)"); },
            adEnded: function() { postMessageToBridge("\(AdEvent.adEnded.rawValue)"); },
            adClosed: function() { postMessageToBridge("\(AdEvent.adClosed.rawValue)"); },
            adPaused: function() { postMessageToBridge("\(AdEvent.adPaused.rawValue)"); },
            adPlaying: function() { postMessageToBridge("\(AdEvent.adPlaying.rawValue)"); },
            webSDKReady: function() { postMessageToBridge("\(AdEvent.webSDKReady.rawValue)"); }
        };
    """
}
