//
//  UIViewController+Extensions.swift
//  Alamofire
//
//  Created by Gunhan Sancar on 02/09/2020.
//

import UIKit

extension UIViewController {

    func getTopMostViewController() -> UIViewController {
        switch self {
        case let tab as UITabBarController:
            if let selected = tab.selectedViewController {
                return selected.getTopMostViewController()
            } else {
                return tab
            }
        case let nav as UINavigationController:
            if let topViewController = nav.presentedViewController {
                return topViewController.getTopMostViewController()
            } else {
                return nav
            }
        default:
            if let presentedViewController = presentedViewController {
                return presentedViewController.getTopMostViewController()
            } else {
                return self
            }
        }
    }

    func showQuestionDialog(title: String,
                            message: String,
                            yesTitle: String,
                            noTitle: String,
                            yesAction: VoidBlock?,
                            noAction: VoidBlock?) -> UIAlertController {
        let controller = UIAlertController(title: title,
                                           message: message,
                                           preferredStyle: .alert)

        let yesUIAction = UIAlertAction(title: yesTitle, style: .default) {_ in
            yesAction?()
        }

        let noUIAction = UIAlertAction(title: noTitle, style: .default) {_ in
            noAction?()
        }

        controller.addAction(yesUIAction)
        controller.addAction(noUIAction)

        controller.view.accessibilityIdentifier = "SuperAwesome.Alerts.Question"
        yesUIAction.accessibilityIdentifier = "SuperAwesome.Alerts.Question.Button.Yes"
        noUIAction.accessibilityIdentifier = "SuperAwesome.Alerts.Question.Button.No"

        present(controller, animated: true)

        return controller
    }
}
