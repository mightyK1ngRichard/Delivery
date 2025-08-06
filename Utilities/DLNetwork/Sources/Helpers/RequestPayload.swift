//
// Created by Dmitriy Permyakov on 05.08.2025
// Copyright © 2025 Dostavka24. All rights reserved.
//

public struct RequestPayload {

    let body: [String: Any?]
    let includeToken: Bool

    public static func basic(
        _ body: [String: Any?] = [:],
        includeToken: Bool = true
    ) -> Self {
        return .init(body: body, includeToken: includeToken)
    }
}
