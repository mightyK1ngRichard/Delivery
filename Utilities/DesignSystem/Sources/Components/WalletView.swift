//
// WalletView.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 25.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

struct WalletView: View {
    var moneyCount: String
    var size: TitleSize = .size11

    enum TitleSize: CGFloat {
        case size11 = 11
        case size17 = 17
    }

    var body: some View {
        IconTextView
            .padding(.vertical, 5)
            .padding(.horizontal, 8)
            .background(DLColor<BackgroundPalette>.yellow.color, in: .rect(cornerRadius: 8))
    }

    private var IconTextView: some View {
        HStack {
            Image(.money)
                .frame(width: 12, height: 12)

            Text(moneyCount)
                .style(
                    size: size.rawValue,
                    weight: .semibold,
                    color: DLColor<TextPalette>.primary.color
                )
        }
    }
}

// MARK: - Preview

#Preview {
    WalletView(moneyCount: "1234")
}
