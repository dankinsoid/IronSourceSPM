//
//  AdProcessor.swift
//  SuperAwesome
//
//  Created by Gunhan Sancar on 02/07/2020.
//

protocol AdProcessorType {
    /// Processes the  given `ad` and creates and `HTML` or `VAST` fields.
    ///
    /// - Parameter placementId: Used while forming HTML tags
    /// - Parameter ad: The `Ad` object to be processed
    /// - Parameter requestOptions: The additional data sent with the ad's request. Should be nil if no additional data was sent.
    /// - Parameter openRtbPartnerId: optional OpenRtbPartnerId parameter
    /// - Parameter completion: Callback closure to be notified once the process is completed
    /// - Returns `AdResponse` object which contains `HTML` or `VAST` fields to be shown
    func process(_ placementId: Int,
                 _ ad: Ad,
                 _ openRtbPartnerId: String?,
                 _ requestOptions: [String: Any]?,
                 completion: @escaping OnComplete<AdResponse>)
}

class AdProcessor: AdProcessorType {
    private let htmlFormatter: HtmlFormatterType
    private let vastParser: VastParserType
    private let networkDataSource: NetworkDataSourceType
    private let videoCache: VideoCacheType
    private let logger: LoggerType

    init(htmlFormatter: HtmlFormatterType,
         vastParser: VastParserType,
         networkDataSource: NetworkDataSourceType,
         videoCache: VideoCacheType,
         logger: LoggerType) {
        self.htmlFormatter = htmlFormatter
        self.vastParser = vastParser
        self.networkDataSource = networkDataSource
        self.videoCache = videoCache
        self.logger = logger
    }

    func process(_ placementId: Int,
                 _ ad: Ad,
                 _ openRtbPartnerId: String?,
                 _ requestOptions: [String: Any]?,
                 completion: @escaping OnComplete<AdResponse>) {
        let response = AdResponse(placementId, ad, openRtbPartnerId, requestOptions)

        switch ad.creative.format {
        case .imageWithLink:
            response.html = htmlFormatter.formatImageIntoHtml(ad)
            response.baseUrl = ad.creative.details.image?.baseUrl
            completion(response)
        case .richMedia:
            response.html = htmlFormatter.formatRichMediaIntoHtml(placementId, ad)
            response.baseUrl = (ad.creative.details.url ?? Constants.defaultBaseUrl).baseUrl
            completion(response)
        case .tag:
            response.html = htmlFormatter.formatTagIntoHtml(ad)
            response.baseUrl = Constants.defaultBaseUrl
            completion(response)
        case .video:
            if ad.isVpaid == true {

                if let tag = ad.creative.details.tag,
                   let cleanBaseUrl = tag.extractURLs().first?.absoluteString.baseUrl {
                    response.baseUrl = cleanBaseUrl
                }

                response.html = ad.creative.details.tag
                completion(response)
            } else if let vastXml = ad.creative.details.vastXml,
                      AwesomeAds.shared.globalFeatureFlagsManager.globalFeatureFlags?.isAdResponseVASTEnabled == true,
                      !vastXml.isEmpty {
                handleVastXml(vastXml) { [weak self] vast in
                    self?.populateResponse(withVast: vast, response: response, completion: completion)
                }
            } else if let url = ad.creative.details.vast {
                handleVast(url, initialVast: nil) { [weak self] vast in
                    self?.populateResponse(withVast: vast, response: response, completion: completion)
                }
            } else if let url = ad.creative.details.video {
                downloadFile(withUrl: url, response: response) { result in completion(result) }
            } else {
                completion(response)
            }
        case .unknown: completion(response)
        }
    }

    private func downloadFile(withUrl url: String, response: AdResponse, completion: @escaping OnComplete<AdResponse>) {
        videoCache.get(url: url) { localFilePath in
            response.filePath = localFilePath
            completion(response)
        }
    }

    private func populateResponse(withVast vast: VastAd?,
                                  response: AdResponse,
                                  completion: @escaping OnComplete<AdResponse>) {
        response.vast = vast
        response.baseUrl = (vast?.url ??? Constants.defaultBaseUrl).baseUrl
        guard let vastUrl = vast?.url else {
            completion(response)
            return
        }
        downloadFile(withUrl: vastUrl, response: response) { result in completion(result) }
    }

    private func handleVastXml(_ vastXml: String,
                               initialVast: VastAd? = nil,
                               isRedirect: Bool = false,
                               completion: @escaping OnComplete<VastAd?>) {
        guard let data = vastXml.data(using: .utf8) else {
            logger.info("Unable to convert VAST XML to data")
            completion(nil)
            return
        }
        processVast(withData: data, initialVast: initialVast, isRedirect: isRedirect, completion: completion)
    }

    private func handleVast(_ url: String,
                            initialVast: VastAd?,
                            isRedirect: Bool = false,
                            completion: @escaping OnComplete<VastAd?>) {
        networkDataSource.getData(url: url) { [weak self] result in
            switch result {
            case .success(let data):
                self?.processVast(withData: data,
                                  initialVast: initialVast,
                                  isRedirect: isRedirect,
                                  completion: completion)
            case .failure:
                completion(initialVast)
            }
        }
    }

    private func processVast(withData data: Data,
                             initialVast: VastAd?,
                             isRedirect: Bool = false, 
                             completion: @escaping OnComplete<VastAd?>) {
        let vast = vastParser.parse(data)
        if let redirect = vast?.redirect, !isRedirect {
            let mergedVast = vast?.merge(from: initialVast)
            handleVast(redirect, initialVast: mergedVast, isRedirect: true, completion: completion)
        } else {
            let mergedVast = vast?.merge(from: initialVast)
            completion(mergedVast)
        }
    }
}
