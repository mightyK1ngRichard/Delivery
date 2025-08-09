//
// Created by Dmitriy Permyakov on 05.08.2025
// Copyright © 2025 Dostavka24. All rights reserved.
//

import Foundation

public enum NetworkClientError: Error, Equatable {

    case clientError(NetworkError)
    case unownedError(Error)
}

extension NetworkClientError: LocalizedError {

    public var errorDescription: String? {
        switch self {
        case let .clientError(networkError):
            switch networkError {
            case .invalidURL:
                "Некорректный URL"
            case let .bodyEncodingFailed(error):
                "Не удалось закодировать параметры запроса, \(error.localizedDescription)"
            case .explicitlyCancelled:
                "Запрос был отменён"
            case .invalidResponse:
                "Ответ сервера не соответствует ожидаемому формату"
            case let .decodingFailed(error):
                "Ошибка декодирования JSON: \(error.localizedDescription)"
            case let .requiredFieldMissing(payload):
                "Отсутствуют обязательные поля в JSON: \(payload.rawValue)"
            }
        case let .unownedError(error):
            "Неизвестная ошибка: \(error.localizedDescription)"
        }
    }

    public static func == (lhs: NetworkClientError, rhs: NetworkClientError) -> Bool {
        switch (lhs, rhs) {
        case let (.clientError(lhs), .clientError(rhs)):
            return lhs == rhs
        case (.unownedError, .unownedError):
            return true
        default:
            return false
        }
    }
}
