//
//  PublisherConfig.swift
//  SuperAwesome
//
//  Created by Myles Eynon on 27/10/2023.
//

import Foundation

struct PublisherConfig: Codable {
    let parentalGateOn: Bool
    let bumperPageOn: Bool
    let closeWarning: Bool?
    let orientation: Orientation?
    let closeAtEnd: Bool?
    let muteOnStart: Bool?
    let showMore: Bool?
    let startDelay: Int?
    let closeButtonState: CloseButtonState?
}
