//
// Created by Dmitriy Permyakov on 05.08.2025
// Copyright © 2025 Dostavka24. All rights reserved.
//

import Foundation

public struct DataResponse: Sendable {

    public let data: Data
    public let httpResponse: HTTPURLResponse

    public var statusCode: Int {
        httpResponse.statusCode
    }
}

public struct ModelResponse<Model: Decodable & Sendable>: Sendable {

    /// Декодированная модель.
    public let model: Model

    /// Оригинальный ответ с данными и HTTP-статусом.
    public let dataResponse: DataResponse
}
