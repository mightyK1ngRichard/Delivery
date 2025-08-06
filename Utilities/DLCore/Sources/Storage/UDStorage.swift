//
// UDStorage.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 27.06.2025
// Copyright © 2025 Dostavka24. All rights reserved.
//

import Foundation
import Combine

@propertyWrapper
public struct UDStorage<T> {

    private let key: String
    private let _publisher: CurrentValueSubject<T?, Never>
    private let _userDefaults: UserDefaults
    private let _observer: ObserverTrampoline<T>

    public var projectedValue: AnyPublisher<T?, Never> {
        _publisher.eraseToAnyPublisher()
    }

    public var wrappedValue: T? {
        get { _userDefaults.object(forKey: key) as? T }
        set { _userDefaults.set(newValue, forKey: key) }
    }

    public init(_ key: UDKey, userDefaults: UserDefaults = .standard) {
        self.init(key: key.rawValue, userDefaults: userDefaults)
    }

    public init(key: String, userDefaults: UserDefaults = .standard) {
//        assert(T.self == URL.self, "UDStorage does not support URL.Type")

        self.key = key
        _userDefaults = userDefaults

        let publisher = CurrentValueSubject<T?, Never>(nil)
        _publisher = publisher

        _observer = ObserverTrampoline<T>(userDefaults: userDefaults, key: key) { newValue in
            publisher.send(newValue)
        }
    }

    public init(key: String, defaultValue: T, userDefaults: UserDefaults = .standard) {
//        assert(T.self == URL.self, "UDStorage does not support URL.Type")

        self.key = key
        _userDefaults = userDefaults
        _userDefaults.set(defaultValue, forKey: key)

        let publisher = CurrentValueSubject<T?, Never>(defaultValue)
        _publisher = publisher

        _observer = ObserverTrampoline<T>(userDefaults: userDefaults, key: key) { newValue in
            publisher.send(newValue)
        }
    }
}
