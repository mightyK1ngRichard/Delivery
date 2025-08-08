//
// DTag+Helpers.swift
// iOS-Delivery24
//
// Created by Garbuzov Matvey on 16.06.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

extension DTag {

    enum IconKind: Hashable {
        case clear
        case discount
        case hits
        case new
    }
}

extension DTag.IconKind {

    var icon: String? {
        switch self {
        case .clear:
            return nil
        case .discount:
            return "discount"
        case .hits:
            return "hits"
        case .new:
            return "new"
        }
    }
}
