//
//  CodeableExcluded.swift
//  SuperAwesome
//
//  Created by Tom O'Rourke on 02/02/2023.
//

@propertyWrapper
public struct CodableExcluded<Value> {

    public var wrappedValue: Value? {
        get { value }
        set { self.value = newValue }
    }

    private var value: Value?

    public init(wrappedValue: Value?) {
        self.value = wrappedValue
    }
}
extension CodableExcluded: Codable {

    public func encode(to encoder: Encoder) throws {}

    public init(from decoder: Decoder) throws {
        self.value = nil
    }
}
