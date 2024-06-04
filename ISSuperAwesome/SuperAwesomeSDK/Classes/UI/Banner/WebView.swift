//
//  WebView.swift
//  SuperAwesome
//
//  Created by Gunhan Sancar on 24/08/2020.
//

import WebKit

protocol WebViewDelegate: AnyObject {
    /// Called when the WebView finishes its loading for the first time
    func webViewOnStart()
    func webViewOnError()
    func webViewOnClick(url: URL)
}

class WebView: WKWebView {
    weak var delegate: WebViewDelegate?

    private var finishedLoading = false

    override init(frame: CGRect, configuration: WKWebViewConfiguration) {
        super.init(frame: frame, configuration: configuration)
        configure()
    }

    func loadHTML(_ html: String?, withBase base: String?, sourceSize: CGSize) {
        print("WebView.loadHTML called")
        // embed html code inside a full html wrapper
        let baseHtml = """
        <html>
           <head>
            <meta name="viewport" content="width=device-width initial-scale=1" />
            <style>html, body, div { margin: 0px; padding: 0px; } html, body { width:100%; height:100%; } </style>
          </head>
          <body>\(html ?? "")</body>
        </html>
"""

        // lock-and-load
        if let data = baseHtml.data(using: .utf8), let url = URL(string: base ?? "") {
            load(data, mimeType: "text/html", characterEncodingName: "UTF-8", baseURL: url)
        }
    }

    func loadAdViaJsScript(placementId: Int, adRequest: AdRequest) {
        let dict = try? JSONDecoder().decode([String: Int].self, from: JSONEncoder().encode(adRequest))
        let queryParams = dict?.filter {
            String(describing: $0.key) != "test"
        }.map { key, value in
            "&\(key)=\(value)"
        }.joined(separator: "") ?? ""
        let html = """
<html>
  <header>
   <meta name='viewport' content='width=device-width'/>
   <style>html, body, div { margin: 0px; padding: 0px; } html, body { width: 100%; height: 100%; }</style>
  </header>
  <body>
    <script type="text/javascript"
    src="https://ads.superawesome.tv/v2/ad.js?placement=\(placementId)\(queryParams)">
    </script>
  </body>
</html>
"""
        loadHTMLString(html, baseURL: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure() {
        scrollView.delegate = self
        scrollView.isScrollEnabled = true
        scrollView.bounces = false
        self.uiDelegate = self
        self.navigationDelegate = self
        backgroundColor = .clear
    }

    /**
     * "defaultConfiguration" Returns the default web player configuration,
     * to be used when initialising this web view
     *
     * @return  default configuration for the web player
     */
    class func defaultConfiguration() -> WKWebViewConfiguration {
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true
        configuration.mediaTypesRequiringUserActionForPlayback = []
        if #available(iOS 13.0, *) {
            let preferences = WKWebpagePreferences()
            preferences.preferredContentMode = .mobile
            configuration.defaultWebpagePreferences = preferences
        }
        return configuration
    }
}

extension WebView: UIScrollViewDelegate {
    /**
     * Overridden "viewForZoomingInScrollView:" method from the
     * UIScrollViewDelegate protocol
     *
     * - Parameter scrollView: The current scroll view of the web view
     * - Returns: A scrolled zoomed UIView; or nil in this case
     */
    func viewForZooming(in scrollView: UIScrollView) -> UIView? { nil }
}

extension WebView: WKUIDelegate {
    func webView(_ webView: WKWebView,
                 createWebViewWith configuration: WKWebViewConfiguration,
                 for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if finishedLoading {
            var url = navigationAction.request.url
            let urlString = url?.absoluteString

            // protect against about blanks
            if urlString?.contains("about:blank") ?? false {
                return nil
            }

            // protect against iframes
            if urlString?.contains("sa-beta-ads-uploads-superawesome.netdna-ssl.com") ?? false &&
                urlString?.contains("/iframes") ?? false {
                return nil
            }

            // check to see if the URL has a redirect, and take only the redirect
            if urlString?.contains("&redir=") ?? false {
                if let redirectString = urlString?.suffix(from: "&redir="),
                   let redirectUrl = URL(string: redirectString) {
                    url = redirectUrl
                }
            }

            if let url = url {
                delegate?.webViewOnClick(url: url)
            }
        }

        return nil
    }

    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard finishedLoading else {
            decisionHandler(WKNavigationActionPolicy.allow)
            return
        }

        var url = navigationAction.request.url
        let urlString = url?.absoluteString

        // protect against about blanks
        if urlString?.contains("about:blank") ?? false {
            decisionHandler(WKNavigationActionPolicy.allow)
            return
        }

        // protect against iframes
        if urlString?.contains("sa-beta-ads-uploads-superawesome.netdna-ssl.com") ?? false &&
            urlString?.contains("/iframes") ?? false {
            decisionHandler(WKNavigationActionPolicy.allow)
            return
        }

        // check to see if the URL has a redirect, and take only the redirect
        if urlString?.contains("&redir=") ?? false {
            if let redirectString = urlString?.suffix(from: "&redir="),
               let redirectUrl = URL(string: redirectString) {
                url = redirectUrl
            }
        }

        if let url = url {
            delegate?.webViewOnClick(url: url)
        }

        decisionHandler(WKNavigationActionPolicy.cancel)
    }
}

extension WebView: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if !finishedLoading {
            finishedLoading = true
            delegate?.webViewOnStart()
        }
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        if !finishedLoading {
            finishedLoading = true
            delegate?.webViewOnError()
        }
    }
}
