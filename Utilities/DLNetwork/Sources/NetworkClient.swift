//
//  Created by Dmitriy Permyakov on 05.08.2025.
//  Copyright © 2025 Dostavka24. All rights reserved.
//

import Foundation
import DLCore

public final class NetworkClient {

    private let hostProvider: AnyServerHostProvider
    private let networkStore: AnyNetworkStore
    private let session: URLSession

    private let logger = DLLogger("Network Client")

    public init(
        hostProvider: AnyServerHostProvider,
        networkStore: AnyNetworkStore,
        session: URLSession = .shared
    ) {
        self.hostProvider = hostProvider
        self.networkStore = networkStore
        self.session = session
    }
}

// MARK: - AnyNetworkClient

extension NetworkClient: AnyNetworkClient {

    public func request<Entity: Decodable & Sendable>(
        _ path: String,
        method: HTTPMethod,
        options: RequestOptions?,
        decodeTo: Entity.Type
    ) async throws(NetworkClientError) -> ModelResponse<Entity> {
        let url = hostProvider.host.url.appending(path: path)

        let dataResponse = try await request(path, method: method, options: options)
        do {
            let model = try JSONDecoder().decode(Entity.self, from: dataResponse.data)
            return ModelResponse(model: model, dataResponse: dataResponse)
        } catch {
            logger.error("✗ HTTP \(url) - ошибка декодинга")
            throw .clientError(.decodingFailed(error))
        }
    }

    public func request(
        _ path: String,
        method: HTTPMethod,
        options: RequestOptions?
    ) async throws(NetworkClientError) -> DataResponse {
        let url = hostProvider.host.url.appending(path: path)
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        // Формируем body
        if let options {
            do {
                let data = try await makeRequestBody(options: options)
                request.httpBody = data
            } catch {
                throw error
            }
        }

        // Формируем заголовки
        request.setValue(.json, for: .contentType)
        request.setValue(.json, for: .accept)

        // Запрос
        let response: (Data, URLResponse)
        do {
            logger.info("→ /\(method.rawValue) \(url)")
            response = try await session.data(for: request)
        } catch {
            logger.error("✗ HTTP \(url) - \(error.localizedDescription)")
            throw .unownedError(error)
        }

        guard let httpResponse = response.1 as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            logger.error("✗ HTTP \(url) - плохой статус код")
            throw NetworkClientError.clientError(.invalidResponse)
        }

        logger.info("← HTTP \(httpResponse.statusCode) \(url)")
        return DataResponse(data: response.0, httpResponse: httpResponse)
    }

    private func makeRequestBody(options: RequestOptions) async throws(NetworkClientError) -> Data {
        var body: [String: Any] = options.body ?? [:]

        func insertRequired(_ key: AddionPayload, value: Any?) throws(NetworkClientError) {
            guard let value else {
                throw .clientError(.requiredFieldMissing(key))
            }
            body[key.rawValue] = value
        }

        func insertOptional(_ key: AddionPayload, value: Any?) {
            if let value {
                body[key.rawValue] = value
            }
        }

        // tokenID
        if options.required.contains(.tokenID) {
            try await insertRequired(.tokenID, value: networkStore.token)
        } else if options.required.contains(.tokenID) {
            insertOptional(.tokenID, value: await networkStore.token)
        }

        // addressID
        if options.required.contains(.addressID) {
            try await insertRequired(.addressID, value: networkStore.addressID)
        } else if options.optional.contains(.addressID) {
            insertOptional(.addressID, value: await networkStore.addressID)
        }

        do {
            return try JSONSerialization.data(withJSONObject: body)
        } catch {
            throw .clientError(.bodyEncodingFailed(error))
        }
    }
}

// MARK: - Private

private extension URLRequest {

    mutating func setValue(_ value: HTTPValues.ContentType, for header: HTTPValues.Header) {
        setValue(value.rawValue, forHTTPHeaderField: header.rawValue)
    }
}
