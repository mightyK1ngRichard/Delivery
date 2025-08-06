//
// DProductCard+Helpers.swift
// iOS-Delivery24
//
// Created by Garbuzov Matvey on 17.07.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

// MARK: - Helpers

// Закругление для верхний углов
struct CustomShape: Shape {
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: .CRx5, height: .CRx5)
        )
        return Path(path.cgPath)
    }
}

enum Tags: String {
    case promotion = "Акция"
    case hit = "Хит"
    case exclusive = "Экслюзив"
    case news = "Новинка"
}

extension Tags {

    var backgroundColor: Color {
        switch self {
        case .promotion: return .purple
        case .hit: return .orange
        case .exclusive: return .green
        case .news: return .blue
        }
    }
}
