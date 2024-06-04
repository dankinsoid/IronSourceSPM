//
//  AdQueryMaker.swift
//  SuperAwesome
//
//  Created by Gunhan Sancar on 17/04/2020.
//

protocol AdQueryMakerType {
    func makeAdQuery(_ request: AdRequest, pubConfig: PublisherConfig) -> QueryBundle
    func makeImpressionQuery(_ adResponse: AdResponse) -> QueryBundle
    func makeClickQuery(_ adResponse: AdResponse) -> QueryBundle
    func makeEventQuery(_ adResponse: AdResponse, _ eventData: EventData) -> QueryBundle
    func makeFeatureFlagsQuery(placementId: Int, lineItemId: Int?, creativeId: Int?) -> QueryBundle
}

class AdQueryMaker: AdQueryMakerType {
    private let device: DeviceType
    private let sdkInfo: SdkInfoType
    private let connectionProvider: ConnectionProviderType
    private let numberGenerator: NumberGeneratorType
    private let idGenerator: IdGeneratorType
    private let encoder: EncoderType
    private let options: [String: Any]?

    init(device: DeviceType,
         sdkInfo: SdkInfoType,
         connectionProvider: ConnectionProviderType,
         numberGenerator: NumberGeneratorType,
         idGenerator: IdGeneratorType,
         encoder: EncoderType,
         options: [String: Any]?) {
        self.device = device
        self.sdkInfo = sdkInfo
        self.connectionProvider = connectionProvider
        self.numberGenerator = numberGenerator
        self.idGenerator = idGenerator
        self.encoder = encoder
        self.options = options
    }

    func makeAdQuery(_ request: AdRequest, pubConfig: PublisherConfig) -> QueryBundle {
        QueryBundle(parameters: AdQuery(test: request.test,
                                        sdkVersion: sdkInfo.version,
                                        random: numberGenerator.nextIntForCache(),
                                        bundle: sdkInfo.bundle,
                                        name: sdkInfo.name,
                                        dauid: idGenerator.uniqueDauId,
                                        connectionType: connectionProvider.findConnectionType(),
                                        lang: sdkInfo.lang,
                                        device: device.genericType,
                                        position: request.position.rawValue,
                                        skip: request.skip.rawValue,
                                        playbackMethod: request.playbackMethod,
                                        startDelay: request.startDelay.rawValue,
                                        instl: request.instl.rawValue,
                                        width: request.width,
                                        height: request.height,
                                        openRtbPartnerId: request.openRtbPartnerId,
                                        publisherConfiguration: encoder.toJson(pubConfig)),
                    options: buildOptions(with: request.options))
    }

    func makeImpressionQuery(_ adResponse: AdResponse) -> QueryBundle {
        QueryBundle(parameters: EventQuery(placement: adResponse.placementId,
                                           bundle: sdkInfo.bundle,
                                           creative: adResponse.advert.creative.id,
                                           lineItem: adResponse.advert.lineItemId,
                                           connectionType: connectionProvider.findConnectionType(),
                                           sdkVersion: sdkInfo.version,
                                           rnd: adResponse.advert.rnd ?? "",
                                           type: .impressionDownloaded,
                                           noImage: true,
                                           data: nil,
                                           adRequestId: adResponse.advert.adRequestId,
                                           openRtbPartnerId: adResponse.openRtbPartnerId),
                    options: buildOptions(with: adResponse.requestOptions))
    }

    func makeClickQuery(_ adResponse: AdResponse) -> QueryBundle {
        QueryBundle(parameters: EventQuery(placement: adResponse.placementId,
                                           bundle: sdkInfo.bundle,
                                           creative: adResponse.advert.creative.id,
                                           lineItem: adResponse.advert.lineItemId,
                                           connectionType: connectionProvider.findConnectionType(),
                                           sdkVersion: sdkInfo.version,
                                           rnd: adResponse.advert.rnd ?? "",
                                           type: nil,
                                           noImage: nil,
                                           data: nil,
                                           adRequestId: adResponse.advert.adRequestId,
                                           openRtbPartnerId: adResponse.openRtbPartnerId),
                    options: buildOptions(with: adResponse.requestOptions))
    }

    func makeEventQuery(_ adResponse: AdResponse, _ eventData: EventData) -> QueryBundle {
        QueryBundle(parameters: EventQuery(placement: adResponse.placementId,
                                           bundle: sdkInfo.bundle,
                                           creative: adResponse.advert.creative.id,
                                           lineItem: adResponse.advert.lineItemId,
                                           connectionType: connectionProvider.findConnectionType(),
                                           sdkVersion: sdkInfo.version,
                                           rnd: adResponse.advert.rnd ?? "",
                                           type: eventData.type,
                                           noImage: nil,
                                           data: encoder.toJson(eventData),
                                           adRequestId: adResponse.advert.adRequestId,
                                           openRtbPartnerId: adResponse.openRtbPartnerId),
                    options: buildOptions(with: adResponse.requestOptions))
    }

    func makeFeatureFlagsQuery(placementId: Int, lineItemId: Int?, creativeId: Int?) -> QueryBundle {
        QueryBundle(parameters: FeatureFlagsQuery(placementId: placementId,
                                                  bundle: sdkInfo.bundle,
                                                  lineItemId: lineItemId,
                                                  creativeId: creativeId,
                                                  connectionType: connectionProvider.findConnectionType(),
                                                  sdkVersion: sdkInfo.version,
                                                  device: device.genericType),
                    options: nil)
    }

    private func buildOptions(with requestOptions: [String: Any]?) -> [String: Any] {
        var optionsDict = [String: Any]()

        if let options = options {
            merge(options, with: &optionsDict)
        }

        if let requestOptions = requestOptions {
            merge(requestOptions, with: &optionsDict)
        }
        return optionsDict
    }

    private func merge( _ new: [String: Any], with original: inout [String: Any]) {
        for (key, value) in new {
            switch value {
            case let value as String:
                original[key] = value
            case let value as Int:
                original[key] = value
            default:
                continue
            }
        }
    }
}
