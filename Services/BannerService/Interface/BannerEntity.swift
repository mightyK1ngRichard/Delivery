//
// Created by Dmitriy Permyakov on 06.08.2025
// Copyright © 2025 Dostavka24. All rights reserved.
//

public struct BannerEntity: Decodable, Sendable {

    let id: Int?
    let title: String?
    public let image: String?
    let link: String?
    let sortOrder: Int?
    let text: String?
    let createdAt: String?
    let updatedAt: String?
    let type: Int?
}

extension BannerEntity {

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case image
        case link
        case sortOrder = "sort_order"
        case text
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case type
    }
}
