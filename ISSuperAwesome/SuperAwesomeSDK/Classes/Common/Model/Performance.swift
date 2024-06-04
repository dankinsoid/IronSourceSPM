//
//  Performance.swift
//  SuperAwesome
//
//  Created by Gunhan Sancar on 26/05/2023.
//

struct PerformanceMetricTags: Codable {
    let sdkVersion: String
    let placementId: String
    let lineItemId: String
    let creativeId: String
    let connectionType: String
    let format: CreativeFormatType
}

struct PerformanceMetric: Codable {
    let value: Int64
    let metricName: PerformanceMetricName
    let metricType: PerformanceMetricType
    let metricTags: PerformanceMetricTags
    
    func build() -> [String: Any] {
        
        var payload: [String: Any] = [
            "value": value,
            "metricName": metricName.rawValue,
            "metricType": metricType.rawValue
        ]
        
        if let metricTags = CustomEncoder().toJson(metricTags) {
            payload["metricTags"] = metricTags
        }
        
        return payload
    }
}

enum PerformanceMetricName: String, Codable {
    case closeButtonPressTime = "sa.ad.sdk.close.button.press.time.ios"
    case dwellTime = "sa.ad.sdk.dwell.time.ios"
    case loadTime = "sa.ad.sdk.performance.load.time.ios"
    case renderTime = "sa.ad.sdk.performance.render.time.ios"
    case closeButtonFallbackShown = "sa.ad.sdk.performance.fallback.close.shown.ios"
}

enum PerformanceMetricType: String, Codable {
    case gauge
    case increment
    case decrementBy
    case decrement
    case histogram
    case incrementBy
    case timing
}
