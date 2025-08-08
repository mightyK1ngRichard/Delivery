//
// Created by Dmitriy Permyakov on 05.08.2025
// Copyright © 2025 Dostavka24. All rights reserved.
//

public enum NetworkError: Error {

    case invalidURL
    case requiredFieldMissing(AddionPayload)
    case explicitlyCancelled
    case invalidResponse
    case bodyEncodingFailed(any Error)
    case decodingFailed(any Error)
}
