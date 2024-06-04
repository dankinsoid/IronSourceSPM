//
//  Completion.swift
//  SuperAwesome
//
//  Created by Gunhan Sancar on 17/04/2020.
//

/// Callback function for success & failure results
typealias OnResult<T> = (_ result: Result<T, Error>) -> Void

/// Callback function for completable events
typealias OnComplete<T> = (_ result: T) -> Void

/// Callback function for callable events
typealias VoidBlock = () -> Void

/// Callback function for callable events with an Int parameter
typealias IntBlock = (Int) -> Void
