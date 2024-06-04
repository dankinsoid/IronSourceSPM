//
//  String+Extensions.swift
//  SuperAwesome
//
//  Created by Gunhan Sancar on 08/04/2020.
//

import Foundation
import CommonCrypto

extension String {

    /// Returns the Int value of a string
    var toInt: Int? { Int(self) }

    /// Returns an MD5 has of the current string
    var toMD5: String {
        let data = Data(utf8) as NSData
        var hash = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5(data.bytes, CC_LONG(data.length), &hash)
        return hash.map { String(format: "%02hhx", $0) }.joined()
    }

    /// Returns the base url formed from a full url
    var baseUrl: String? {
        guard let url = URL(string: self),
                let scheme = url.scheme,
                let host = url.host else { return nil }
        if let port = url.port {
            return "\(scheme)://\(host):\(port)"
        }
        return "\(scheme)://\(host)"
    }

    /// Returns the extension name or nil
    var fileExtension: String? {
        let parts = components(separatedBy: ".")
        return parts.count > 1 ? parts.last : nil
    }

    func extractURLs() -> [URL] {
        var urls: [URL] = []
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
            detector.enumerateMatches(in: self, options: [], range: NSRange(0..<self.count), using: { result, _, _ in
                if let match = result, let url = match.url {
                    urls.append(url)
                }
            })
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return urls
    }
}

extension StringProtocol {
    func indexUpperBound<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.upperBound
    }

    /// Returns a string which is substring of the given string starting at the end of `from` parameter
    func suffix(from: String) -> String? {
        if let index = indexUpperBound(of: from) {
            return String(suffix(from: index))
        }
        return nil
    }
}

/// `???` operator returns the second parameter if the first parameter is null or empty
infix operator ???

func ??? (lhs: String?, rhs: String) -> String {
    guard let given = lhs, !given.isEmpty else { return rhs }
    return given
}
