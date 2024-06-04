//
//  CloseButtonState.swift
//  SuperAwesome
//
//  Created by Tom O'Rourke on 08/06/2022.
//

import Foundation

@objc
public enum CloseButtonState: Int, Codable {
    case visibleWithDelay = 0
    case visibleImmediately = 1
    case hidden = 2
    case custom = 3
}
