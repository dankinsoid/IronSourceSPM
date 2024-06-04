//
//  Constraint+Extensions.swift
//  SuperAwesome
//
//  Created by Gunhan Sancar on 07/09/2020.
//

extension NSLayoutConstraint {
    /// Sets the priority for the current constraint and returns itself
    func withPriority(_ value: Float) -> NSLayoutConstraint {
        self.priority = UILayoutPriority(value)
        return self
    }
}
