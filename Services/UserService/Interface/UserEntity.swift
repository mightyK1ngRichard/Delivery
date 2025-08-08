//
// Created by Dmitriy Permyakov on 05.08.2025
// Copyright © 2025 Dostavka24. All rights reserved.
//

public struct UserEntity: Decodable, Sendable {

    public let id: Int?
    public let email: String?
    let emailVerifiedAt: String?
    let role: Int?
    let createdAt: String?
    let updatedAt: String?
    public let phone: String?
    public let name: String?
    public let address: String?
    public let inn: String?
    public let kpp: String?
    let addressFact: String?
    let guid: String?
    public let balance: String?
    let verifyFlagEmail: Int?
    let verifyFlagPhone: Int?
    let verifyCodeEmail: String?
    let verifyCodePhone: String?
    let cart: String?
    let ageLimitFlag: Int?
    let tgAuthCode: String?
    let tgID: Int?
    let minOrder: Int?
    let managerID: Int?
    public let token: String?
    let currentAddressID: Int?
    let salesFlag: Int?
    let tgAuthCodeSales: Int?
    let tgIdSales: String?
}

// MARK: - CodingKeys

extension UserEntity {

    enum CodingKeys: String, CodingKey {
        case id
        case email
        case emailVerifiedAt = "email_verified_at"
        case role
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case phone
        case name
        case address
        case inn
        case kpp
        case addressFact = "address_fact"
        case guid
        case balance
        case verifyFlagEmail = "verify_flag_email"
        case verifyFlagPhone = "verify_flag_phone"
        case verifyCodeEmail = "verify_code_email"
        case verifyCodePhone = "verify_code_phone"
        case cart
        case ageLimitFlag = "age_limit_flag"
        case tgAuthCode = "tg_auth_code"
        case tgID = "tg_id"
        case minOrder = "min_order"
        case managerID = "manager_id"
        case token
        case currentAddressID = "current_address_id"
        case salesFlag = "sales_flag"
        case tgAuthCodeSales = "tg_auth_code_sales"
        case tgIdSales = "tg_id_sales"
    }
}
