//
//  Created by Dmitriy Permyakov on 07.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

public struct UserModel: Identifiable, Hashable {

    public let id: Int
    public let email: String
    public let phone: String
    public let name: String
    public let address: String
    public let inn: String
    public let kpp: String
    public let balance: String

    public init(
        id: Int,
        email: String,
        phone: String,
        name: String,
        address: String,
        inn: String,
        kpp: String,
        balance: String
    ) {
        self.id = id
        self.email = email
        self.phone = phone
        self.name = name
        self.address = address
        self.inn = inn
        self.kpp = kpp
        self.balance = balance
    }
}
