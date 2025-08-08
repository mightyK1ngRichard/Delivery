//
// DProductCardModel.swift
// iOS-Delivery24
//
// Created by Garbuzov Matvey on 17.07.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

public struct DProductCardModel: Identifiable {

    public let id: Int
    var imageURL: URL?
    var isLike: Bool
    let title: String
    let price: String
    let description: String
    let startCounter: Int
    let magnifier: Int
    let tags: [Tags]

    public init(
        id: Int,
        imageURL: URL? = nil,
        isLike: Bool = false,
        title: String,
        price: String,
        description: String,
        startCounter: Int,
        magnifier: Int,
        tags: [Tags]
    ) {
        self.id = id
        self.imageURL = imageURL
        self.isLike = isLike
        self.title = title
        self.price = price
        self.description = description
        self.startCounter = startCounter
        self.magnifier = magnifier
        self.tags = tags
    }
}
