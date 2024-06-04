//
//  NumberGenerator.swift
//  SuperAwesome
//
//  Created by Gunhan Sancar on 20/04/2020.
//

protocol NumberGeneratorType {

    /// Generates a random number between`parentalGateMin` and `parentalGateMax`
    func nextIntForParentalGate() -> Int

    /// Generates a random number between `cacheBoundMin` and `cacheBoundMax`
    func nextIntForCache() -> Int

    /// Generates a random alpha numeric String for a given `length`
    func nextAlphanumericString(length: Int) -> String
}

class NumberGenerator: NumberGeneratorType {
    private static let parentalGateMin: Int = 50
    private static let parentalGateMax: Int = 99
    private static let cacheBoundMin: Int = 1000000
    private static let cacheBoundMax: Int = 1500000
    private static let alphanumericChars: String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

    func nextIntForCache() -> Int { Int.random(in: NumberGenerator.cacheBoundMin..<NumberGenerator.cacheBoundMax) }

    func nextAlphanumericString(length: Int) -> String {
        String((0..<length).map { _ in NumberGenerator.alphanumericChars.randomElement()! })
    }

    func nextIntForParentalGate() -> Int {
        Int.random(in: NumberGenerator.parentalGateMin..<NumberGenerator.parentalGateMax)
    }
}
