//
//  Padding.swift
//  SuperAwesome
//
//  Created by Tom O'Rourke on 27/06/2022.
//

internal enum Padding: CGFloat {
    case s = 8.0

    public var value: CGFloat {
        rawValue
    }

    public var negative: CGFloat {
        -1.0 as CGFloat * rawValue
    }
}
