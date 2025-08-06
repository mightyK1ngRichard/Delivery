//
//  Created by Dmitriy Permyakov on 06.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

public protocol AnyAuthService: Sendable {
    func signIn(email: String, password: String) async throws
}
