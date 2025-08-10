//
// Created by Dmitriy Permyakov on 24.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Kingfisher
import SwiftUI
import DLCore

// MARK: - Configuration

extension DLCategoryBlock {

    public struct Configuration {

        var isShimmering = false
        var cells: [CellData] = []

        public init(isShimmering: Bool = false, cells: [CellData] = []) {
            self.isShimmering = isShimmering
            self.cells = cells
        }
    }
}

extension DLCategoryBlock.Configuration {

    public struct CellData: Identifiable {

        public let id: Int
        var title: String
        var imageURL: URL?

        public init(id: Int, title: String, imageURL: URL? = nil) {
            self.id = id
            self.title = title
            self.imageURL = imageURL
        }
    }
}

// MARK: - DLCategoryBlock

public struct DLCategoryBlock: View {

    private let configuration: Configuration
    private let didSelectIcon: DLIntBlock

    @State
    private var size: CGSize = .zero
    private var height: CGFloat {
        max((size.width - .SPx2 * 2 - .SPx4 * 2) / 3, 0)
    }

    public init(configuration: Configuration, didSelectIcon: @escaping DLIntBlock) {
        self.configuration = configuration
        self.didSelectIcon = didSelectIcon
    }

    public var body: some View {
        MainContainer
    }
}

// MARK: - UI Subviews

// (width - SPx2 * 2 - SPx4 * 2) / 3
private extension DLCategoryBlock {

    @ViewBuilder
    var MainContainer: some View {
        if configuration.isShimmering {
            ShimmeringContainer
        } else {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 3), spacing: .SPx2) {
                MainData
            }
            .bindSize($size)
        }
    }

    var ShimmeringContainer: some View {
        VStack(spacing: .SPx2) {
            HStack(spacing: .SPx2) {
                ForEach(0..<3) { _ in
                    ShimmeringKind
                }
            }
            HStack(spacing: .SPx2) {
                ForEach(3..<6) { _ in
                    ShimmeringKind
                }
            }
            HStack(spacing: .SPx2) {
                ForEach(6..<9) { _ in
                    ShimmeringKind
                }
            }
        }
        .bindSize($size)
    }

    var ShimmeringKind: some View {
        ShimmeringView()
            .frame(height: height)
            .clipShape(.rect(cornerRadius: 20))
    }

    @ViewBuilder
    var MainData: some View {
        ForEach(0..<configuration.cells.count, id: \.self) { index in
            CellView(for: index)
                .frame(height: height)
                .onTapGesture {
                    didSelectIcon(configuration.cells[index].id)
                }
        }
    }

    func CellView(for index: Int) -> some View {
        DLImageView(
            configuration: .init(
                imageKind: .url(configuration.cells[index].imageURL)
            )
        )
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(lineWidth: 1)
                .fill(DLColor<SeparatorPalette>.grayBorder.color)
        }
        .overlay(alignment: .bottomLeading) {
            ZStack(alignment: .bottomLeading) {
                LinearGradient(
                    colors: [.black, .clear],
                    startPoint: .bottom,
                    endPoint: .top
                )
                .opacity(0.6)

                Text(configuration.cells[index].title)
                    .style(size: 15, weight: .semibold, color: DLColor<TextPalette>.white.color)
                    .padding([.horizontal, .bottom], 12)
            }
        }
        .clipShape(.rect(cornerRadius: 20))
    }
}
