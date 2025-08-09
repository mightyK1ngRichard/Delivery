//
// Created by Dmitriy Permyakov on 05.08.2025
// Copyright © 2025 Dostavka24. All rights reserved.
//

public enum NetworkError: Error, Equatable, Sendable {

    case invalidURL
    case requiredFieldMissing(AddionPayload)
    case explicitlyCancelled
    case invalidResponse
    case bodyEncodingFailed(any Error)
    case decodingFailed(any Error)
}

// MARK: - Equatable

extension NetworkError {

    public static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL):
            return true
        case let (.requiredFieldMissing(lhs), .requiredFieldMissing(rhs)):
            return lhs == rhs
        case (.explicitlyCancelled, .explicitlyCancelled):
            return true
        case (.invalidResponse, .invalidResponse):
            return true
        case (.bodyEncodingFailed, .bodyEncodingFailed):
            return true
        case (.decodingFailed, .decodingFailed):
            return true
        default:
            return false
        }
    }
}
