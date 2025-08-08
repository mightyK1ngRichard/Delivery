//
//  Created by Dmitriy Permyakov on 08.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

public protocol AnyNetworkClient: Sendable {

    func request(
        _ path: String,
        method: HTTPMethod,
        options: RequestOptions?
    ) async throws(NetworkClientError) -> DataResponse

    func request<Entity: Decodable & Sendable>(
        _ path: String,
        method: HTTPMethod,
        options: RequestOptions?,
        decodeTo: Entity.Type
    ) async throws(NetworkClientError) -> ModelResponse<Entity>

}
