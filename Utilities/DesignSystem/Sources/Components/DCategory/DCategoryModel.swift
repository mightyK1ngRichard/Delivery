//
// Created by Garbuzov Matvey on 17.07.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

public struct DCategoryModel: Identifiable {

    public let id: Int
    let imageURL: URL?
    let title: String

    public init(id: Int, imageURL: URL?, title: String) {
        self.id = id
        self.imageURL = imageURL
        self.title = title
    }
}
