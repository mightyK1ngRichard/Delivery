//
// Created by Dmitriy Permyakov on 06.08.2025
// Copyright © 2025 Dostavka24. All rights reserved.
//

import Foundation
import DLCore
import DLNetwork
import AuthServiceInterface

public struct AuthServiceImpl {

    private let networkStore: AnyNetworkStore
    private let networkClient: AnyNetworkClient
    private let logger = DLLogger("Auth Service")

    public init(
        networkStore: AnyNetworkStore,
        networkClient: AnyNetworkClient
    ) {
        self.networkStore = networkStore
        self.networkClient = networkClient
    }
}

// MARK: - AnyAuthService

extension AuthServiceImpl: AnyAuthService {

    public func signIn(email: String, password: String) async throws {
        let data = try await networkClient.request(
            "auth",
            method: .post,
            body: .basic([
                "email": email,
                "password": password
            ], includeToken: false)
        ).data

        do {
            let reponse = try JSONDecoder().decode(AuthEntity.self, from: data)
            await networkStore.setToken(reponse.token)
        } catch {
            throw NetworkError.decodingFailed(error)
        }
    }
}
