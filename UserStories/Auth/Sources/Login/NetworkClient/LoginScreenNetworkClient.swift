//
//  Created by Dmitriy Permyakov on 12.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import AuthServiceInterface

struct LoginScreenNetworkClient: AnyLoginScreenNetworkClient {

    let authService: AnyAuthService

    func makeLogin(email: String, password: String) async throws {
        try await authService.signIn(email: email, password: password)
    }
}
