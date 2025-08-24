//
// Created by Dmitriy Permyakov on 05.08.2025
// Copyright © 2025 Dostavka24. All rights reserved.
//

import Foundation
import DLCore

public struct Address: Codable, Sendable {

    public let id: Int
    public let title: String?

    public init(id: Int, title: String?) {
        self.id = id
        self.title = title
    }
}

public protocol AnyNetworkStore: Sendable, Actor {
    var token: String? { get }
    var balance: Double? { get }
    var address: Address? { get }

    func setToken(_ newToken: String?)
    func setAddress(_ newAddress: Address?)
    func setBalance(_ newBalance: Double?)
}

public actor NetworkStore: AnyNetworkStore {

    private var _token: String?
    @UDStorage(.userToken)
    private var _stotedToken: String?

    private var _address: Address?
    private var _balance: Double?

    private let logger = DLLogger("Network Store")

    public init() {}

    public var token: String? {
        _token ?? _stotedToken
    }

    public func setToken(_ newToken: String?) {
        _token = newToken
        _stotedToken = newToken
        logger.info("Токен установлен")
    }

    public var address: Address? {
        return _address
    }

    public func setAddress(_ newAddress: Address?) {
        _address = newAddress
        logger.info("Адрес установлен")
    }

    public var balance: Double? {
        _balance
    }

    public func setBalance(_ newBalance: Double?) {
        _balance = newBalance
        logger.info("Баланс установлен")
    }
}
