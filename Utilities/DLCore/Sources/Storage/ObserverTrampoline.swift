//
// ObserverTrampoline.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 29.06.2025
// Copyright © 2025 Dostavka24. All rights reserved.
//

import Foundation

final class ObserverTrampoline<T>: NSObject {

    private let userDefaults: UserDefaults
    private let key: String
    private let action: (T?) -> Void

    init(userDefaults: UserDefaults, key: String, action: @escaping (T?) -> Void) {
        assert(!key.hasPrefix("@"), "Error: key name cannot begin with a '@' character and be observed via KVO.")
        assert(!key.contains("."), "Error: key name cannot contain a '.' character anywhere and be observed via KVO.")
        self.userDefaults = userDefaults
        self.key = key
        self.action = action
        super.init()

        userDefaults.addObserver(self, forKeyPath: key, context: nil)
    }

    deinit {
        self.userDefaults.removeObserver(self, forKeyPath: self.key, context: nil)
    }

    override func observeValue(
        forKeyPath _: String?,
        of _: Any?,
        change: [NSKeyValueChangeKey: Any]?,
        context _: UnsafeMutableRawPointer?
    ) {
        let newValue = change?[.newKey] as? T
        action(newValue)
    }
}
