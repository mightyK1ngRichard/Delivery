//
// DontResultView.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 26.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

struct DontResultView: View {
    struct Configuration {
        var resource: ImageResource
        var title: String
        var subtitle: String
    }

    var configuration: Configuration

    var body: some View {
        VStack(spacing: 16) {
            Image(configuration.resource)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)

            VStack(spacing: 4) {
                Text(configuration.title)
                    .style(size: 17, weight: .regular, color: DLColor<TextPalette>.primary.color)

                Text(configuration.subtitle)
                    .style(size: 13, weight: .regular, color: DLColor<TextPalette>.gray800.color)
            }
        }
    }
}
