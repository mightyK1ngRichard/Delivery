//
// Created by Dmitriy Permyakov on 05.08.2025
// Copyright © 2025 Dostavka24. All rights reserved.
//

import Foundation
import DLCore

public protocol AnyNetworkStore: Sendable, Actor {
    var token: String? { get }
    var addressID: String? { get }
    func setToken(_ newToken: String)
    func setAddressID(_ newAdderessID: String)
}

public actor NetworkStore: AnyNetworkStore {

    private var _token: String?
    @UDStorage(.userToken)
    private var _stotedToken: String?

    private var _addressID: String?
    @UDStorage(.addressID)
    private var _stotedAddressID: String?

    public init() {}

    public var token: String? {
        _token ?? _stotedToken
    }

    public func setToken(_ newToken: String) {
        _stotedToken = newToken
        _token = newToken
    }

    public var addressID: String? {
        _addressID ?? _stotedAddressID
    }

    public func setAddressID(_ newAdderessID: String) {
        _addressID = newAdderessID
        _stotedAddressID = newAdderessID
    }
}
