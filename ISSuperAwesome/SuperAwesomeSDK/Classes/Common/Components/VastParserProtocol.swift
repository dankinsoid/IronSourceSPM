//
//  VastParser.swift
//  SuperAwesome
//
//  Created by Gunhan Sancar on 06/07/2020.
//

/// Protocol to parse VAST XML documents
protocol VastParserType {
    func parse(_ data: Data) -> VastAd?
}
