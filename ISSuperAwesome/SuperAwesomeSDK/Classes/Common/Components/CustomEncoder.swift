//
//  Encoder.swift
//  SuperAwesome
//
//  Created by Gunhan Sancar on 21/04/2020.
//

protocol EncoderType {
    func encodeUri(_ string: String?) -> String
    func toJson<T: Encodable>(_ encodable: T) -> String?
}

class CustomEncoder: EncoderType {
    private let escapedSet = CharacterSet(charactersIn: "!*'\"();:@&=+$,/?%#[]% ").inverted
    private let jsonEncoder = JSONEncoder()

    func encodeUri(_ string: String?) -> String {
        guard let string = string, string.count > 0 else { return "" }
        return string.addingPercentEncoding(withAllowedCharacters: escapedSet) ?? ""
    }

    func toJson<T: Encodable>(_ encodable: T) -> String? {
        do {
            let jsonData = try jsonEncoder.encode(encodable)

            if let jsonString = String(data: jsonData, encoding: .utf8) {
                return jsonString
            }
        } catch {
            print("Encoder.toJson.error: \(error.localizedDescription)")
        }
        return nil
    }

}
