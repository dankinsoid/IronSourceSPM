//
//  OrientationProvider.swift
//  SuperAwesome
//
//  Created by Gunhan Sancar on 07/09/2020.
//

import UIKit

protocol OrientationProviderType {
    func findSupportedOrientations(_ orientation: Orientation, _ defaultOrientations: UIInterfaceOrientationMask) -> UIInterfaceOrientationMask
}

class OrientationProvider: OrientationProviderType {
    private let bundle: Bundle

    init(_ bundle: Bundle) {
        self.bundle = bundle
    }

    func findSupportedOrientations(_ orientation: Orientation, _ defaultOrientations: UIInterfaceOrientationMask) -> UIInterfaceOrientationMask {
        guard let supportedOrientations = bundle.infoDictionary?["UISupportedInterfaceOrientations"] as? [String]
            else { return defaultOrientations }

        switch orientation {
        case .any:
            return defaultOrientations
        case .portrait:
            let hasPortrait = supportedOrientations.contains("UIInterfaceOrientationPortrait")
            let hasPortraitUpsideDown = supportedOrientations.contains("UIInterfaceOrientationPortraitUpsideDown")

            if hasPortrait && hasPortraitUpsideDown {
                return [.portrait, .portraitUpsideDown]
            } else if hasPortrait {
                return .portrait
            } else if hasPortraitUpsideDown {
                return .portraitUpsideDown
            } else {
                return defaultOrientations
            }
        case .landscape:
            let hasLandscapeLeft = supportedOrientations.contains("UIInterfaceOrientationLandscapeLeft")
            let hasLandscapeRight = supportedOrientations.contains("UIInterfaceOrientationLandscapeRight")

            if hasLandscapeLeft && hasLandscapeRight {
                return .landscape
            } else if hasLandscapeLeft {
                return .landscapeLeft
            } else if hasLandscapeRight {
                return .landscapeRight
            } else {
                return defaultOrientations
            }
        }
    }
}
