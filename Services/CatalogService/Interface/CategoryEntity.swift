//
// Created by Dmitriy Permyakov on 06.08.2025.
// Copyright © 2025 Dostavka24. All rights reserved.
//

import Foundation

public struct CategoryEntity: Decodable, Sendable, Hashable, Identifiable {

    public let id: Int
    public let title: String?
    let status: Int?
    public let parentID: Int?
    let createdAt: String?
    let updatedAt: String?
    let extID: String?
    let showOnMain: Int?
    public let image: String?
    let ageLimitFlag: Int?
    let text: String?

    public init(
        id: Int,
        title: String?,
        status: Int?,
        parentID: Int?,
        createdAt: String?,
        updatedAt: String?,
        extID: String?,
        showOnMain: Int?,
        image: String?,
        ageLimitFlag: Int?,
        text: String?
    ) {
        self.id = id
        self.title = title
        self.status = status
        self.parentID = parentID
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.extID = extID
        self.showOnMain = showOnMain
        self.image = image
        self.ageLimitFlag = ageLimitFlag
        self.text = text
    }
}

extension CategoryEntity {

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case status
        case parentID = "parent_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case extID = "ext_id"
        case showOnMain = "show_on_main"
        case image
        case ageLimitFlag = "age_limit_flag"
        case text
    }
}
