//
// DTag+Helpers.swift
// iOS-Delivery24
//
// Created by Garbuzov Matvey on 16.06.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation
import SwiftUI

extension DTag {

    public enum IconKind: Hashable {
        case clear
        case discount
        case hits
        case new
    }
}

extension DTag.IconKind {

    var icon: Image? {
        switch self {
        case .clear:
            return nil
        case .discount:
            return DLIcon.discount.image
        case .hits:
            return DLIcon.hits.image
        case .new:
            return DLIcon.new.image
        }
    }
}
