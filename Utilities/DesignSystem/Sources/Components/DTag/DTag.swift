//
// DTag.swift
// iOS-Delivery24
//
// Created by Garbuzov Matvey on 16.06.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

public struct DTag: View {

    var iconKind: IconKind = .clear
    var title: String

    public init(iconKind: IconKind, title: String) {
        self.iconKind = iconKind
        self.title = title
    }

    public var body: some View {
        HStack(spacing: .SPx2) {
            if let icon = iconKind.icon {
                icon
                    .renderingMode(.template)
                    .foregroundStyle(
                        iconKind == .hits ? Color("TagHitsIcon", bundle: .module) : Color("Contraste", bundle: .module)
                    )
            }

            Text(title)
        }
        .padding(.horizontal, .SPx3)
        .padding(.vertical, .SPx2)
        .background(Color("TagBG", bundle: .module))
        .clipShape(RoundedRectangle(cornerRadius: .CRx3))
    }
}

#Preview {
    DTag(iconKind: .discount, title: "Discount")
}
