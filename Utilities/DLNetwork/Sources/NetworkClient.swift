//
//  Created by Dmitriy Permyakov on 05.08.2025.
//  Copyright © 2025 Dostavka24. All rights reserved.
//

import Foundation
import DLCore

public protocol AnyNetworkClient: Sendable {
    func request(
        _ path: String,
        method: HTTPMethod,
        body: RequestPayload?
    ) async throws(NetworkClientError) -> DataResponse
}

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

    public func request(
        _ path: String,
        method: HTTPMethod,
        body: RequestPayload?
    ) async throws(NetworkClientError) -> DataResponse {
        let url = hostProvider.host.url.appending(path: path)
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        // Формируем body
        if let payload = body {
            var body = payload.body
            if payload.includeToken {
                body["token"] = await networkStore.getToken()
            }
            
            let bodyData: Data
            do {
                bodyData = try JSONSerialization.data(withJSONObject: body)
            } catch {
                logger.error("✗ HTTP \(url) - ошибка кодирования body: \(error.localizedDescription)")
                throw .clientError(.bodyEncodingFailed(error))
            }

            request.httpBody = bodyData
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
            logger.error("✗ HTTP \(url) - bad status code")
            throw NetworkClientError.clientError(.invalidResponse)
        }

        logger.info("← HTTP \(httpResponse.statusCode) \(url)")
        return DataResponse(data: response.0, httpResponse: httpResponse)
    }
}

// MARK: - Private

private extension URLRequest {

    mutating func setValue(_ value: HTTPValues.ContentType, for header: HTTPValues.Header) {
        setValue(value.rawValue, forHTTPHeaderField: header.rawValue)
    }
}
