//
// Created by Dmitriy Permyakov on 06.08.2025
// Copyright © 2025 Dostavka24. All rights reserved.
//

public struct PopcatsEntity: Decodable, Sendable {

    public let id: Int?
    public let title: String?
    let status: Int?
    let parentID: Int?
    let createdAt: String?
    let updatedAt: String?
    let extID: String?
    let showOnMain: Int?
    public let image: String?
    let ageLimitFlag: Int?
    let text: String?

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
