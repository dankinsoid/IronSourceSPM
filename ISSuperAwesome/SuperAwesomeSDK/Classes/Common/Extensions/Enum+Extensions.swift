//
//  Enum+Extensions.swift
//  SuperAwesome
//
//  Created by Gunhan Sancar on 28/08/2020.
//

/// This protocol allows the decoded enum to be set to the last
/// enum value if there is no match instead of throwing an error
protocol DecodableDefaultLastItem: Decodable & CaseIterable & RawRepresentable
where RawValue: Decodable, AllCases: BidirectionalCollection { }

extension DecodableDefaultLastItem {
    init(from decoder: Decoder) throws {
        self = try Self(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? Self.allCases.last!
    }
}
