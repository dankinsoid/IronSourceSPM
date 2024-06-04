//
//  ClickHandler.swift
//  SuperAwesome
//
//  Created by Gunhan Sancar on 08/09/2020.
//

import Moya

protocol AdControllerType {
    var parentalGateEnabled: Bool { get set }
    var bumperPageEnabled: Bool { get set }
    var testEnabled: Bool { get set }
    var closed: Bool { get set }
    var showPadlock: Bool { get }
    var callback: AdEventCallback? { get set }
    var adResponse: AdResponse? { get set }
    var videoDelegate: AdControllerVideoDelegate? { get set }
    var filePathUrl: URL? { get }
    var adAvailable: Bool { get }
    var currentAd: Ad? { get }
    
    func handleAdTapForVast(completion: (() -> Void)?)
    func handleAdTap(url: URL, completion: (() -> Void)?)
    func handleSafeAdTap()
    
    func load(_ placementId: Int, _ request: AdRequest, pubConfig: PublisherConfig)
    func load(_ placementId: Int, lineItemId: Int, creativeId: Int, _ request: AdRequest, pubConfig: PublisherConfig)
    func close()
    
    // performance metrics
    func trackCloseButtonVisible()
    func trackCloseButtonClicked()
    func trackAdShown()
    func trackAdClosed()
    func trackCloseButtonFallbackShown()
    func trackRenderTime(renderTime: Int64)

    // delegate events
    func adEnded()
    func adFailedToShow()
    func adShown()
    func adClosed()
    func adPaused()
    func adPlaying()

    // trigger web events
    func triggerViewableImpression()
    func triggerImpressionEvent()
    func triggerDwellTime()
}

public protocol AdControllerVideoDelegate: AnyObject {
    func controllerDidRequestPlayVideo()
    func controllerDidRequestPauseVideo()
}

class AdController: AdControllerType, Injectable {

    private lazy var logger: LoggerType = dependencies.resolve(param: AdController.self)
    private lazy var eventRepository: EventRepositoryType = dependencies.resolve()
    private lazy var adRepository: AdRepositoryType = dependencies.resolve()
    private lazy var timeProvider: TimeProviderType = dependencies.resolve()
    private lazy var performanceRepository: PerformanceRepositoryType = dependencies.resolve()

    private var parentalGate: ParentalGate?
    private var lastClickTime: TimeInterval = 0
    
    // performance metrics
    private var closeButtonTimer: PerformanceTimer?
    private var dwellTimeTimer: PerformanceTimer?
    private var loadTimeTimer: PerformanceTimer?
    
    var parentalGateEnabled: Bool = false
    var bumperPageEnabled: Bool = false
    var testEnabled = false
    var closed = false
    var adResponse: AdResponse?
    var callback: AdEventCallback?
    weak var videoDelegate: AdControllerVideoDelegate?
    var placementId: Int { adResponse?.placementId ?? 0 }
    var showPadlock: Bool { adResponse?.advert.showPadlock ?? false}
    var adAvailable: Bool { adResponse != nil }
    var currentAd: Ad? { adResponse?.advert }
    
    private lazy var parentalGateOpenAction = { [weak self] in
        guard let adResponse = self?.adResponse else { return }
        self?.eventRepository.parentalGateOpen(adResponse, completion: nil)
    }
    
    private lazy var parentalGateCancelAction = { [weak self] in
        guard let adResponse = self?.adResponse else { return }
        self?.videoDelegate?.controllerDidRequestPlayVideo()
        self?.eventRepository.parentalGateClose(adResponse, completion: nil)
    }
    
    private lazy var parentalGateSuccessAction = { [weak self] in
        guard let adResponse = self?.adResponse else { return }
        self?.eventRepository.parentalGateSuccess(adResponse, completion: nil)
    }
    
    private lazy var parentalGateFailAction = { [weak self] in
        guard let adResponse = self?.adResponse else { return }
        self?.videoDelegate?.controllerDidRequestPlayVideo()
        self?.eventRepository.parentalGateFail(adResponse, completion: nil)
    }
    
    var filePathUrl: URL? {
        guard let filePath = adResponse?.filePath else { return nil }
        return URL(fileURLWithPath: filePath)
    }
    
    func close() {
        trackAdClosed()
        callback?(placementId, .adClosed)
        logger.info("Event callback: adClosed for placement \(placementId)")
        adResponse = nil
        closed = true
    }
    
    func adFailedToShow() {
        callback?(placementId, .adFailedToShow)
        logger.info("Event callback: adFailedToShow for placement \(placementId)")
    }
    
    func adShown() {
        callback?(placementId, .adShown)
        logger.info("Event callback: adShown for placement \(placementId)")
    }
    
    func adEnded() {
        callback?(placementId, .adEnded)
        logger.info("Event callback: adEnded for placement \(placementId)")
    }
    
    func adClosed() {
        callback?(placementId, .adClosed)
        logger.info("Event callback: adClosed for placement \(placementId)")
    }
    
    func adPaused() {
        callback?(placementId, .adPaused)
        logger.info("Event callback: adPaused for placement \(placementId)")
    }
    
    func adPlaying() {
        callback?(placementId, .adPlaying)
        logger.info("Event callback: adPlaying for placement \(placementId)")
    }
    
    func triggerViewableImpression() {
        guard let adResponse = adResponse else { return }
        eventRepository.viewableImpression(adResponse, completion: nil)
        logger.info("Event callback: viewableImpression for placement \(placementId)")
    }
    
    func triggerImpressionEvent() {
        guard let adResponse = adResponse else { return }
        eventRepository.impression(adResponse, completion: nil)
        logger.info("Event callback: impression for placement \(placementId)")
    }
    
    func triggerDwellTime() {
        guard let adResponse = adResponse else { return }
        eventRepository.dwellTime(adResponse, completion: nil)
        logger.info("Event callback: dwellTime for placement \(placementId)")
    }
    
    func trackCloseButtonClicked() {
        guard let closeButtonTimer = closeButtonTimer, 
              let adResponse = adResponse else { return }
        performanceRepository.sendCloseButtonPressTime(adResponse: adResponse,
                                                       value: closeButtonTimer.calculate(),
                                                       completion: nil)
    }
    
    func trackCloseButtonVisible() {
        guard closeButtonTimer == nil else { return }
        closeButtonTimer = PerformanceTimer(timeProvider: dependencies.resolve() as TimeProviderType)
    }
    
    func trackAdShown() {
        guard dwellTimeTimer == nil else { return }
        dwellTimeTimer = PerformanceTimer(timeProvider: dependencies.resolve() as TimeProviderType)
    }
    
    func trackAdClosed() {
        guard let dwellTimeTimer = dwellTimeTimer, 
              let adResponse = adResponse else { return }
        performanceRepository.sendDwellTime(adResponse: adResponse,
                                            value: dwellTimeTimer.calculate(),
                                            completion: nil)
        self.dwellTimeTimer = nil
    }
    
    func trackLoadTimeStart() {
        guard loadTimeTimer == nil else { return }
        loadTimeTimer = PerformanceTimer(timeProvider: dependencies.resolve() as TimeProviderType)
    }
    
    func trackLoadTimeEnd() {
        guard let loadTimeTimer = loadTimeTimer, 
              let adResponse = adResponse else { return }
        performanceRepository.sendLoadTime(adResponse: adResponse,
                                           value: loadTimeTimer.calculate(),
                                           completion: nil)
        resetLoadTimeTimer()
    }

    func trackCloseButtonFallbackShown() {
        guard let adResponse = adResponse else { return }
        performanceRepository.sendCloseButtonFallbackShown(adResponse: adResponse,
                                                           completion: nil)
    }

    func trackRenderTime(renderTime: Int64) {
        guard let adResponse = adResponse else { return }
        performanceRepository.sendRenderTime(adResponse: adResponse,
                                             value: renderTime,
                                             completion: nil)
    }

    func resetLoadTimeTimer() {
       loadTimeTimer = nil
    }
    
    func load(_ placementId: Int, _ request: AdRequest, pubConfig: PublisherConfig) {
        trackLoadTimeStart()
        adRepository.getAd(placementId: placementId,
                           request: request,
                           pubConfig: pubConfig) { [weak self] result in
            switch result {
            case .success(let response):
                self?.onSuccess(response)
            case .failure(let error):
                self?.onFailure(error, placementId: placementId)
            }
        }
    }
    
    func load(_ placementId: Int, lineItemId: Int, creativeId: Int, _ request: AdRequest, pubConfig: PublisherConfig) {
        trackLoadTimeStart()
        adRepository.getAd(
            placementId: placementId,
            lineItemId: lineItemId,
            creativeId: creativeId,
            request: request,
            pubConfig: pubConfig) { [weak self] result in
                switch result {
                case .success(let response): 
                    self?.onSuccess(response)
                case .failure(let error):
                    self?.onFailure(error, placementId: placementId)
                }
            }
    }

    private func onSuccess(_ response: AdResponse) {
        adResponse = response
        trackLoadTimeEnd()
        callback?(placementId, .adLoaded)
        logger.success("Event callback: adLoaded for \(response.placementId)")
    }
    
    private func onFailure(_ error: Error, placementId: Int) {
        resetLoadTimeTimer()
        if case MoyaError.objectMapping = error {
            logger.success("Event callback: adEmpty for \(placementId)")
            callback?(placementId, .adEmpty)
        } else {
            logger.error("Event callback: adFailedToLoad for \(placementId)", error: error)
            callback?(placementId, .adFailedToLoad)
        }
    }
    
    /// Shows bumper screen if needed
    private func showBumperIfNeeded(_ url: URL, completion: (() -> Void)?) {
        if bumperPageEnabled || adResponse?.advert.creative.bumper ?? false {
            videoDelegate?.controllerDidRequestPauseVideo()
            BumperPage().play { [weak self] in
                self?.navigateToUrl(url, completion: completion)
            }
        } else {
            navigateToUrl(url, completion: completion)
        }
    }
    
    private func navigateToUrl(_ url: URL, completion: (() -> Void)?) {
        guard let adResponse = adResponse else { return }
        
        let currentTime = timeProvider.secondsSince1970
        let diff = abs(currentTime - lastClickTime)
        
        if Int32(diff) < Constants.defaultClickThresholdInSecs {
            logger.info("Event callback: Ad clicked too quickly: ignored")
            return
        }
        
        lastClickTime = currentTime
        
        callback?(placementId, .adClicked)
        logger.success("Event callback: adClicked for \(placementId)")
        
        completion?()

        if adResponse.advert.creative.format == .video {
            if !doesAdContainVASTClickThroughUrlWithVideoClickEvent(adResponse: adResponse) {
                eventRepository.videoClick(adResponse, completion: nil)
            }
        } else {
            eventRepository.click(adResponse, completion: nil)
        }
        
        UIApplication.shared.open( url, options: [:], completionHandler: nil)
    }

    private func doesAdContainVASTClickThroughUrlWithVideoClickEvent(adResponse: AdResponse?) -> Bool {
        guard let vastAd = adResponse?.vast,
              vastAd.clickThroughUrl != nil,
              vastAd.clickThroughUrl?.contains("/video/click") == true else { return false }
        return true
    }

    func handleAdTapForVast(completion: (() -> Void)?) {
        logger.info("Event callback: adClicked for placement \(placementId)")
        
        guard let clickThroughUrl = adResponse?.vast?.clickThroughUrl ?? adResponse?.advert.creative.clickUrl,
              let url = URL(string: clickThroughUrl) else {
            logger.info("Event callback: Click through URL is not found")
            return
        }
        
        handleAdTap(url: url, completion: completion)
    }
    
    func handleAdTap(url: URL, completion: (() -> Void)?) {
        showParentalGateIfNeeded { [weak self] in
            self?.showBumperIfNeeded(url, completion: completion)
        }
    }
    
    func handleSafeAdTap() {
        showParentalGateIfNeeded(showSuperAwesomeWebPageInSafari)
    }
    
    private func showParentalGateIfNeeded(_ completion: VoidBlock?) {
        if parentalGateEnabled {
            parentalGate?.stop()
            parentalGate = dependencies.resolve() as ParentalGate
            parentalGate?.openAction = parentalGateOpenAction
            parentalGate?.cancelAction = parentalGateCancelAction
            parentalGate?.successAction = { [weak self] in
                self?.parentalGateSuccessAction()
                completion?()
            }
            parentalGate?.failAction = parentalGateFailAction
            videoDelegate?.controllerDidRequestPauseVideo()
            parentalGate?.show()
        } else {
            completion?()
        }
    }
    
    private func showSuperAwesomeWebPageInSafari() {
        let onComplete = {
            if let url = URL(string: Constants.defaultSafeAdUrl) {
                UIApplication.shared.open( url, options: [:], completionHandler: nil)
            }
        }
        
        if bumperPageEnabled {
            videoDelegate?.controllerDidRequestPauseVideo()
            BumperPage().play(onComplete)
        } else {
            onComplete()
        }
    }
}
