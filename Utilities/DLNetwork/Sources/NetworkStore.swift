//
// Created by Dmitriy Permyakov on 05.08.2025
// Copyright © 2025 Dostavka24. All rights reserved.
//

import Foundation
import DLCore

public protocol AnyNetworkStore: Sendable, Actor {
    func getToken() async -> String?
    func setToken(_ newToken: String)
}

public actor NetworkStore: AnyNetworkStore {

    private var token: String?
    @UDStorage(.userToken)
    private var _token: String?

    public init() {}

    public func getToken() async -> String? {
        token ?? _token
    }

    public func setToken(_ newToken: String) {
        token = newToken
        _token = newToken
    }
}
