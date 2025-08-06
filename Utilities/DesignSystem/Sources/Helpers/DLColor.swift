//
// DLColor.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 09.07.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

final class DLColor<Palette: Hashable> {
    let color: Color
    private(set) var uiColor: UIColor

    init(hexLight: Int, hexDark: Int, alphaLight: CGFloat = 1.0, alphaDark: CGFloat = 1.0) {
        let lightColor = UIColor(hex: hexLight, alpha: alphaLight)
        let darkColor = UIColor(hex: hexDark, alpha: alphaDark)
        let uiColor = UIColor { $0.userInterfaceStyle == .light ? lightColor : darkColor }
        self.uiColor = uiColor
        self.color = Color(uiColor: uiColor)
    }

    init(hexLight: Int, hexDark: Int, alpha: CGFloat = 1.0) {
        let chmColor = DLColor(hexLight: hexLight, hexDark: hexDark, alphaLight: alpha, alphaDark: alpha)
        self.uiColor = chmColor.uiColor
        self.color = chmColor.color
    }

    init(uiColor: UIColor) {
        self.uiColor = uiColor
        self.color = Color(uiColor: uiColor)
    }

    init(color: Color) {
        self.uiColor = .clear
        self.color = color
    }
}

// MARK: - Palettes

enum BackgroundPalette: Hashable {}
enum TextPalette: Hashable {}
enum IconPalette: Hashable {}
enum SeparatorPalette: Hashable {}
enum ShadowPalette: Hashable {}
enum CustomPalette: Hashable {}

// MARK: - BackgroundPalette

extension DLColor where Palette == BackgroundPalette {

    /// 0xF5F5F5
    static let lightGray = DLColor(hexLight: 0xF5F5F5, hexDark: 0xF5F5F5)
    /// 0xCCCCCC
    static let lightGray2 = DLColor(hexLight: 0xCCCCCC, hexDark: 0xCCCCCC)
    /// 0xF9F9F9
    static let gray100 = DLColor(hexLight: 0xF9F9F9, hexDark: 0xF9F9F9)
    /// 0x999999
    static let gray300 = DLColor(hexLight: 0x999999, hexDark: 0x999999)
    /// 0xFFD600
    static let yellow = DLColor(hexLight: 0xFFD600, hexDark: 0xFFD600)
    /// 0xFFE8BC
    static let orange = DLColor(hexLight: 0xFFE8BC, hexDark: 0xFFE8BC)
    /// 0x20264D
    static let blue = DLColor(hexLight: 0x20264D, hexDark: 0x20264D)
    /// white
    static let white = DLColor(color: .white)
    /// 0x000000
    static let overlay = DLColor<BackgroundPalette>(hexLight: 0x000000, hexDark: 0x000000, alpha: 0.4)
}

// MARK: - TextPalette

extension DLColor where Palette == TextPalette {

    /// 0x000000
    static let primary = DLColor(hexLight: 0x000000, hexDark: 0x000000)
    /// 0xF5F5F5
    static let gray300 = DLColor(hexLight: 0xF5F5F5, hexDark: 0xF5F5F5)
    /// 0x999999
    static let gray800 = DLColor(hexLight: 0x999999, hexDark: 0x999999)
    /// 0xBAC2C9
    static let placeholder = DLColor(hexLight: 0xBAC2C9, hexDark: 0xBAC2C9)
    /// 0x3E45FF
    static let blue = DLColor(hexLight: 0x3E45FF, hexDark: 0x3E45FF)
    /// 0xFF0000
    static let red = DLColor(hexLight: 0xFF0000, hexDark: 0xFF0000)
    /// 0x20264D
    static let darkBlue = DLColor(hexLight: 0x20264D, hexDark: 0x20264D)
    /// 0x34C759
    static let success = DLColor(hexLight: 0x34C759, hexDark: 0x34C759)
    /// white
    static let white = DLColor(color: .white)
}

// MARK: - IconPalette

extension DLColor where Palette == IconPalette {

    /// 0x000000
    static let primary = DLColor(hexLight: 0x000000, hexDark: 0x000000)
    /// 0x3C3C434D
    static let secondary = DLColor(hexLight: 0x3C3C434D, hexDark: 0x3C3C434D, alpha: 0.3)
    /// 0x999999
    static let gray800 = DLColor(hexLight: 0x999999, hexDark: 0x999999)
    /// 0x20264D
    static let blue = DLColor(hexLight: 0x20264D, hexDark: 0x20264D)
    /// white
    static let white = DLColor(color: .white)
}

// MARK: - SeparatorPalette

extension DLColor where Palette == SeparatorPalette {

    /// 0xE0E4E8
    static let gray = DLColor(hexLight: 0xE0E4E8, hexDark: 0xE0E4E8)
    /// 0x3E45FF
    static let link = DLColor(hexLight: 0x3E45FF, hexDark: 0x3E45FF)
    /// 0xDCDCDC
    static let gray300 = DLColor(hexLight: 0xDCDCDC, hexDark: 0xDCDCDC)
    /// 0xFF7A00
    static let orange = DLColor(hexLight: 0xFF7A00, hexDark: 0xFF7A00)
    /// 0x34C759
    static let green = DLColor(hexLight: 0x34C759, hexDark: 0x34C759)
    /// 0x20264D
    static let blue = DLColor(hexLight: 0x20264D, hexDark: 0x20264D)
    /// 0xEDEFF1
    static let grayBorder = DLColor(hexLight: 0xEDEFF1, hexDark: 0xEDEFF1)
}

// MARK: - ShadowPalette

extension DLColor where Palette == ShadowPalette {

    /// 0x00000014 alpha=0.08
    static let dark = DLColor(hexLight: 0x00000014, hexDark: 0x00000014, alpha: 0.08)
}
