//
//  Bundle+Extensions.swift
//  SuperAwesome
//
//  Created by Gunhan Sancar on 21/04/2020.
//

extension Bundle {
    @objc var versionNumber: String? { infoDictionary?["CFBundleShortVersionString"] as? String }
    @objc var name: String? { infoDictionary?[kCFBundleNameKey as String] as? String }
}
