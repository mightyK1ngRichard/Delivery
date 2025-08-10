//
// DLProductsCarousel.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 28.07.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI
import DLCore

public struct DLProductsCarousel: View {

    private let configuration: Configuration
    private let handlerConfiguration: HandlerConfiguration

    public init(
        configuration: Configuration,
        handlerConfiguration: HandlerConfiguration = .init()
    ) {
        self.configuration = configuration
        self.handlerConfiguration = handlerConfiguration
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            titleContainer
            productsContainer
            Divider()
                .padding(.top, 15)
                .padding(.leading)
        }
    }
}

// MARK: - Configurations

extension DLProductsCarousel {

    public struct Item: Identifiable, Hashable {

        public let id: Int
        let url: URL

        public init(id: Int, url: URL) {
            self.id = id
            self.url = url
        }
    }

    public struct Configuration: Hashable {

        let title: String
        let items: [Item]

        public init(title: String = .init(), items: [Item] = []) {
            self.title = title
            self.items = items
        }
    }

    public struct HandlerConfiguration {

        let onTapTitle: DLVoidBlock?
        let onTapImage: DLGenericBlock<Int>?

        public init(
            onTapTitle: DLVoidBlock? = nil,
            onTapImage: DLGenericBlock<Int>? = nil
        ) {
            self.onTapTitle = onTapTitle
            self.onTapImage = onTapImage
        }
    }
}

// MARK: - UI Subviews

private extension DLProductsCarousel {

    var titleContainer: some View {
        HStack {
            Text(configuration.title)
                .style(size: 17, weight: .semibold, color: DLColor<TextPalette>.primary.color)
            Spacer()
            DLIcon.chivronRight.image
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: 9)
                .foregroundStyle(DLColor<IconPalette>.secondary.color)
                .frame(width: 44, height: 44)
        }
        .padding(.horizontal)
        .onTapGesture {
            handlerConfiguration.onTapTitle?()
        }
    }

    var productsContainer: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: .SPx2) {
                ForEach(configuration.items) { item in
                    productCardView(for: item.url).onTapGesture {
                        handlerConfiguration.onTapImage?(item.id)
                    }
                }
            }
            .padding(.horizontal)
        }
    }

    func productCardView(for url: URL) -> some View {
        DLImageView(
            configuration: .init(
                imageKind: .url(url),
                contentMode: .fit
            )
        )
        .frame(width: 75, height: 100)
        .background(.ultraThinMaterial)
        .clipShape(.rect(cornerRadius: 20))
    }
}
