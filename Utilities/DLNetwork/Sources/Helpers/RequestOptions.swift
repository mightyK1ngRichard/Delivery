//
//  Created by Dmitriy Permyakov on 05.08.2025
//  Copyright © 2025 Dostavka24. All rights reserved.
//

public struct RequestOptions: Sendable {

    nonisolated(unsafe) let body: [String: Any]?
    let required: Set<AddionPayload>
    let optional: Set<AddionPayload>

    public init(
        body: [String: Any]? = nil,
        required: Set<AddionPayload> = [],
        optional: Set<AddionPayload> = []
    ) {
        self.body = body
        self.required = required
        self.optional = optional
    }
}

// MARK: - AddionPayload

public enum AddionPayload: String, Sendable {

    case tokenID = "token"
    case addressID = "address_id"
}
