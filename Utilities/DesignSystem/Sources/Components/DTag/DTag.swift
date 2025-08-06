//
// DTag.swift
// iOS-Delivery24
//
// Created by Garbuzov Matvey on 16.06.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

struct DTag: View {

    var iconKind: IconKind = .clear
    var title: String

    var body: some View {
        HStack(spacing: .SPx2) {
            if let icon = iconKind.icon {
                Image(icon)
                    .renderingMode(.template)
                    .foregroundStyle(iconKind == .hits ? .tagHitsIcon : .contraste)
            }

            Text(title)
        }
        .padding(.horizontal, .SPx3)
        .padding(.vertical, .SPx2)
        .background(.tagBG)
        .clipShape(RoundedRectangle(cornerRadius: .CRx3))
    }
}

#Preview {
    VStack {
        DTag(title: "Акции")
        DTag(iconKind: .discount, title: "Акции")
        DTag(iconKind: .hits, title: "Хиты продаж")
        DTag(iconKind: .new, title: "Новинки")
    }
}
