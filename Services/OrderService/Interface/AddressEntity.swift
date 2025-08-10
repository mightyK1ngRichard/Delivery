//
// Created by Dmitriy Permyakov on 06.08.2025.
// Copyright © 2025 Dostavka24. All rights reserved.
//

import Foundation

public struct AddressEntity: Decodable, Sendable {

    public let id: Int?
    let userID: Int?
    public let title: String?
    let city: String?
    let street: String?
    let house: String?
    let flat: String?
    let createdAt: String?
    let updatedAt: String?
    let stockID: Int?
    public let isMain: Int?
    let minOrder: Int?
    let minDate: String?
    let minSum: Int?
}

extension AddressEntity {

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case title
        case city
        case street
        case house
        case flat
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case stockID = "stock_id"
        case isMain = "is_main"
        case minOrder = "min_order"
        case minDate = "min_date"
        case minSum = "min_sum"
    }
}
