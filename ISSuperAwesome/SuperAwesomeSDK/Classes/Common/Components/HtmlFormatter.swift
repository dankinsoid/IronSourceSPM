//
//  HtmlFormatter.swift
//  SuperAwesome
//
//  Created by Gunhan Sancar on 02/07/2020.
//

protocol HtmlFormatterType {
    func formatImageIntoHtml(_ advert: Ad) -> String
    func formatRichMediaIntoHtml(_ placementId: Int, _ advert: Ad) -> String
    func formatTagIntoHtml(_ advert: Ad) -> String
}

class HtmlFormatter: HtmlFormatterType {
    private let numberGenerator: NumberGeneratorType
    private let encoder: EncoderType

    init(numberGenerator: NumberGeneratorType,
         encoder: EncoderType) {
        self.numberGenerator = numberGenerator
        self.encoder = encoder
    }

    func formatImageIntoHtml(_ advert: Ad) -> String {
        let img = "<img src='\(advert.creative.details.image ?? "")' width='100%' height='100%' style='object-fit: contain;'/>"

        if let clickUrl = advert.creative.clickUrl {
            return "<a href='\(clickUrl)' target='_blank'>\(img)</a>"
        }

        return "\(img)"
    }

    func formatRichMediaIntoHtml(_ placementId: Int, _ ad: Ad) -> String {
        let baseUrl = ad.creative.details.url ?? ""
        let url = "\(baseUrl)?placement=\(placementId)&line_item=\(ad.lineItemId)&creative=\(ad.creative.id)&rnd=\(numberGenerator.nextIntForCache())"
        return "<iframe style='padding:0;border:0;' width='100%' height='100%' src='\(url)'></iframe>"
    }

    func formatTagIntoHtml(_ advert: Ad) -> String {
        var tag = advert.creative.details.tag ?? ""

        if let clickUrl = advert.creative.clickUrl {
            tag = tag.replacingOccurrences(of: "[click]", with: "\(clickUrl)&redir=")
                .replacingOccurrences(of: "[click_enc]", with: encoder.encodeUri(clickUrl))
        } else {
            tag = tag.replacingOccurrences(of: "[click]", with: "")
                .replacingOccurrences(of: "[click_enc]", with: "")
        }

        tag = tag.replacingOccurrences(of: "[keywords]", with: "")
            .replacingOccurrences(of: "[timestamp]", with: "\(Date().timeIntervalSince1970)")
            .replacingOccurrences(of: "target=\"_blank\"", with: "")
            .replacingOccurrences(of: "“", with: "\"")
            .replacingOccurrences(of: "\\t", with: "")
            .replacingOccurrences(of: "\\n", with: "")
            .replacingOccurrences(of: "\t", with: "")

        return "\(tag)"
    }
}
