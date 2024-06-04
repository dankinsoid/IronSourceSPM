//
//  ViewableDetector.swift
//  SuperAwesome
//
//  Created by Gunhan Sancar on 10/09/2020.
//

protocol ViewableDetectorType {
    var whenVisible: IntBlock? { get set }
    func start(for view: UIView, forTickCount: Int, hasBeenVisible: VoidBlock?)
    func start(for view: UIView, hasBeenVisible: VoidBlock?)
    func cancel()
}

class ViewableDetector: ViewableDetectorType {

    private var timer: Timer?
    private weak var view: UIView?
    private var viewableCounter = 0
    private var targetTickCount = 1
    private var hasBeenVisibleDispatched = false

    var hasBeenVisible: VoidBlock?
    var whenVisible: IntBlock?

    func cancel() {
        viewableCounter = 0
        timer?.invalidate()
        timer = nil
        view = nil
        hasBeenVisibleDispatched = false
    }

    func start(for view: UIView, hasBeenVisible: VoidBlock?) {
        cancel()
        self.hasBeenVisible = hasBeenVisible
        self.view = view
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,
                                     selector: #selector(timerFunction), userInfo: nil, repeats: true)
    }

    func start(for view: UIView, forTickCount: Int, hasBeenVisible: VoidBlock?) {
        targetTickCount = forTickCount
        start(for: view, hasBeenVisible: hasBeenVisible)
    }

    @objc
    private func timerFunction() {
        if view?.isVisibleToUser ?? false {
            viewableCounter += 1
            whenVisible?(viewableCounter)
        }

        if viewableCounter >= targetTickCount && hasBeenVisibleDispatched == false {
            hasBeenVisible?()
            hasBeenVisibleDispatched = true
        }
    }

    deinit {
        cancel()
    }
}
