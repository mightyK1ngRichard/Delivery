//
//  Created by Dmitriy Permyakov on 08.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import Foundation

public final class Resolver {

    private static var services: [String: Any] = [:]

    public static func register<T>(_ type: T.Type, _ service: @escaping () -> T) {
        let key = "\(type)"
        services[key] = service
    }

    public static func resolve<T>(_ type: T.Type) -> T {
        let key = "\(type)"
        guard let service = services[key] as? () -> T else {
            fatalError("Service for type \(type) not registered!")
        }

        return service()
    }
}
