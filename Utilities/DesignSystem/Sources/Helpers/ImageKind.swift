//
// ImageKind.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 09.07.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

enum ImageKind {
    case string(String)
    case url(URL?)
    case image(Image)
    case uiImage(UIImage)
}
