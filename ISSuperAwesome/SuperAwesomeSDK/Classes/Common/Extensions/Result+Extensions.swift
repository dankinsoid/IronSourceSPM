//
//  Result+Extensions.swift
//  SuperAwesome
//
//  Created by Gunhan Sancar on 24/04/2020.
//

extension Result {
    var isSuccess: Bool { if case .success = self { return true } else { return false } }
    var isFailure: Bool { return !isSuccess }
}
