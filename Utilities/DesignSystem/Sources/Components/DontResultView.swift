//
// DontResultView.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 26.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

public struct DontResultView: View {

    public struct Configuration: Hashable {

        let resourceName: String
        let title: String
        let subtitle: String

        public init(resourceName: String, title: String, subtitle: String) {
            self.resourceName = resourceName
            self.title = title
            self.subtitle = subtitle
        }
    }

    private let configuration: Configuration

    public init(configuration: Configuration) {
        self.configuration = configuration
    }

    public var body: some View {
        VStack(spacing: 16) {
            Image(configuration.resourceName, bundle: .module)
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
