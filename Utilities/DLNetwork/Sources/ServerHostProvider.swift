//
// Created by Dmitriy Permyakov on 05.08.2025
// Copyright © 2025 Dostavka24. All rights reserved.
//

public protocol AnyServerHostProvider: Sendable {
    var host: ServerHost { get }
}

public final class ServerHostProvider: AnyServerHostProvider {

    public init() {}

    public var host: ServerHost {
        #if DEBUG
            .production
        #else
            .production
        #endif
    }
}
