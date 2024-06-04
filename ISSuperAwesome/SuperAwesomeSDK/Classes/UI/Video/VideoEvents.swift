//
//  SAVideoEvents.swift
//  SuperAwesome
//
//  Created by Gabriel Coman on 18/01/2019.
//

import Foundation

@objc (SAVideoEventsDelegate) public protocol VideoEventsDelegate: AnyObject {
    func hasBeenVisible()
    func whenVisible()
}

class VideoEvents: Injectable {

    private var vastRepository: VastEventRepositoryType?
    private var viewableDetector: ViewableDetectorType?

    private var isStartHandled: Bool = false
    private var is2SHandled: Bool = false
    private var isFirstQuartileHandled: Bool = false
    private var isMidpointHandled: Bool = false
    private var isThirdQuartileHandled: Bool = false

    public weak var delegate: VideoEventsDelegate?

    init(_ adResponse: AdResponse) {
        vastRepository = dependencies.resolve(param: adResponse) as VastEventRepositoryType
    }

    // MARK: - public class interface

    public func clickTracking() {
        vastRepository?.clickTracking()
    }

    public func complete(player: VideoPlayer, time: Int, duration: Int) {
        guard time >= duration else { return }
        vastRepository?.complete()
    }

    public func error(player: VideoPlayer, time: Int, duration: Int) {
        vastRepository?.error()
    }

    public func time(player: VideoPlayer, time: Int, duration: Int) {
        if time >= 1 && !isStartHandled {
            isStartHandled = true
            vastRepository?.impression()
            vastRepository?.creativeView()
            vastRepository?.start()
        }
        if time >= 2 && !is2SHandled {
            is2SHandled = true

            if let videoPlayer = player as? UIView {
                viewableDetector = dependencies.resolve() as ViewableDetectorType
                viewableDetector?.start(for: videoPlayer, hasBeenVisible: { [weak self] in
                    self?.delegate?.hasBeenVisible()
                })
            }
        }
        if time >= duration / 4 && !isFirstQuartileHandled {
            isFirstQuartileHandled = true
            vastRepository?.firstQuartile()
        }
        if time >= duration / 2 && !isMidpointHandled {
            isMidpointHandled = true
            vastRepository?.midPoint()
        }
        if time >= (3 * duration) / 4 && !isThirdQuartileHandled {
            isThirdQuartileHandled = true
            vastRepository?.thirdQuartile()
        }
        
        viewableDetector?.whenVisible = { [weak self] tick in
            if tick % 5 == 0 {
                self?.delegate?.whenVisible()
            }
        }
    }

    deinit {
        viewableDetector = nil
    }
}
