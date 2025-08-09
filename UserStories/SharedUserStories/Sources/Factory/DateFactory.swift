//
//  Created by Dmitriy Permyakov on 09.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import Foundation

public protocol AnyDateFactory: Sendable {
    func calculateExpirationDate(from expirationDate: String?) -> String?
}

public struct DateFactory: AnyDateFactory {

    private static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "ru_RU")
        return dateFormatter
    }()

    public init() {}

    public func calculateExpirationDate(from expirationDate: String?) -> String? {
        guard let daysInt = Int(expirationDate ?? String()) else {
            return nil
        }

        let currentDate = Date()
        var dateComponent = DateComponents()
        dateComponent.day = daysInt
        let calendar = Calendar.current

        guard let futureDate = calendar.date(byAdding: dateComponent, to: currentDate) else {
            return "\(daysInt) дн."
        }

        let formattedDate = Self.dateFormatter.string(from: futureDate)
        return "\(daysInt) дн. (до \(formattedDate))"
    }
}
