//
// Created by Dmitriy Permyakov on 05.08.2025
// Copyright © 2025 Dostavka24. All rights reserved.
//

public struct OrderEntity: Decodable, Sendable {

    public let id: Int?
    let email: String?
    let phone: String?
    let name: String?
    let userID: Int?
    public let totalPrice: String?
    let status: Int?
    public let createdAt: String?
    let updatedAt: String?
    let address: String?
    public let totalCashback: String?
    let chargeFlag: Int?
    let bonus: String?
    let shippingCost: String?
    let sendFlag: Int?
    let changedFlag: Int?
    let paymentType: Int?
    let comment: String?
    let deliveryDate: String?
    let stockID, courierID: Int?

    public init(
        id: Int?,
        email: String?,
        phone: String?,
        name: String?,
        userID: Int?,
        totalPrice: String?,
        status: Int?,
        createdAt: String?,
        updatedAt: String?,
        address: String?,
        totalCashback: String?,
        chargeFlag: Int?,
        bonus: String?,
        shippingCost: String?,
        sendFlag: Int?,
        changedFlag: Int?,
        paymentType: Int?,
        comment: String?,
        deliveryDate: String?,
        stockID: Int?,
        courierID: Int?
    ) {
        self.id = id
        self.email = email
        self.phone = phone
        self.name = name
        self.userID = userID
        self.totalPrice = totalPrice
        self.status = status
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.address = address
        self.totalCashback = totalCashback
        self.chargeFlag = chargeFlag
        self.bonus = bonus
        self.shippingCost = shippingCost
        self.sendFlag = sendFlag
        self.changedFlag = changedFlag
        self.paymentType = paymentType
        self.comment = comment
        self.deliveryDate = deliveryDate
        self.stockID = stockID
        self.courierID = courierID
    }
}

extension OrderEntity {

    enum CodingKeys: String, CodingKey {
        case id, email, phone, name
        case userID = "user_id"
        case totalPrice = "total_price"
        case status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case address
        case totalCashback = "total_cashback"
        case chargeFlag = "charge_flag"
        case bonus
        case shippingCost = "shipping_cost"
        case sendFlag = "send_flag"
        case changedFlag = "changed_flag"
        case paymentType = "payment_type"
        case comment
        case deliveryDate = "delivery_date"
        case stockID = "stock_id"
        case courierID = "courier_id"
    }
}
