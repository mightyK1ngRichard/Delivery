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
                Image(icon, bundle: .module)
                    .renderingMode(.template)
                    .foregroundStyle(
                        iconKind == .hits ? Color("tagHitsIcon", bundle: .module) : Color("contraste", bundle: .module)
                    )
            }

            Text(title)
        }
        .padding(.horizontal, .SPx3)
        .padding(.vertical, .SPx2)
        .background(Color("tagBG", bundle: .module))
        .clipShape(RoundedRectangle(cornerRadius: .CRx3))
    }
}
