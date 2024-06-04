//
//  AwesomeVideoFullscreenPlayer.swift
//  SAVideoPlayer
//
//  Created by Gabriel Coman on 06/02/2019.
//

import Foundation
import UIKit

public class AwesomeVideoFullscreenPlayer: UIViewController {

    private weak var player: AwesomeVideoPlayer!
    private var isPlaying: Bool
    private var previousFrame: CGRect
    private var previousCentre: CGPoint
    public var defaultInterfaceOrientation: UIInterfaceOrientation = .landscapeLeft

    override public var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override public var prefersStatusBarHidden: Bool {
        return true
    }

    override public var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .fade
    }

    override public var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }

    override public var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        let currentOrientation = UIApplication.shared.statusBarOrientation
        switch currentOrientation {
        case .portrait, .portraitUpsideDown:
            return defaultInterfaceOrientation
        default:
            return UIApplication.shared.statusBarOrientation
        }
    }

    override public var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }

    public init(withVideoPlayer player: AwesomeVideoPlayer,
                andIsCurrentlyPlaying playing: Bool) {
        self.player = player
        self.isPlaying = playing
        previousFrame = player.frame
        previousCentre = player.center
        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        player.alpha = 0.0
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(player)
        view.accessibilityIdentifier = "SuperAwesome.Video.FullScreenPlayer"
        player.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isPlaying {
            player.getAVPlayer()?.play()
        }
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            guard let strongSelf = self else { return }
            self?.player.frame = CGRect(x: 0.0,
                                        y: 0.0,
                                        width: strongSelf.view.frame.size.width,
                                        height: strongSelf.view.frame.size.height)
            self?.player.center = strongSelf.view.center
            self?.player.alpha = 1.0
        }, completion: { [weak self] _ in
            self?.player.layoutSubviews()
        })
    }

    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let duration: TimeInterval = animated ? 0.3 : 0.0
        UIView.animate(withDuration: duration, animations: { [weak self] in
            guard let strongSelf = self else { return }
            self?.player.center = strongSelf.previousCentre
        }, completion: { [weak self] _ in
            self?.player.layoutSubviews()
        })
    }

    deinit {
        player = nil
    }

    override public func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { [weak self] _ in
            guard let strongSelf = self else { return }
            self?.player.frame = CGRect(x: 0.0,
                                        y: 0.0,
                                        width: strongSelf.view.frame.size.width,
                                        height: strongSelf.view.frame.size.height)
            self?.player.layoutSubviews()
        })
    }
}

internal extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
