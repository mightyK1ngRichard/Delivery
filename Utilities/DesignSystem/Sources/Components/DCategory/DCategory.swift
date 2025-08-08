//
// DCategory.swift
// iOS-Delivery24
//
// Created by Garbuzov Matvey on 17.07.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI
import Kingfisher

public struct DCategory: View {

    var category: DCategoryModel

    public init(category: DCategoryModel) {
        self.category = category
    }

    public var body: some View {
        MainBlock
            .contentShape(RoundedRectangle(cornerRadius: .CRx5))
            .background(
                RoundedRectangle(cornerRadius: .CRx5)
                    .fill(.background)
            )
            .overlay(
                RoundedRectangle(cornerRadius: .CRx5)
                    .stroke(Constants.borderColor, lineWidth: 1)
            )
            .frame(height: 109)
    }
}

extension DCategory {

    var MainBlock: some View {
        CategoryImage
            .overlay(alignment: .bottomLeading) {
                Text(category.title)
                    .font(.system(size: 15))
                    .bold()
                    .foregroundStyle(.white)
                    .padding(.SPx3)
            }
    }

    var CategoryImage: some View {
        DLImageView(
            configuration: .init(
                imageKind: .url(category.imageURL)
            )
        )
        .overlay {
            LinearGradient(
                colors: [.black, .clear],
                startPoint: .bottom,
                endPoint: .top
            )
            .opacity(0.4)
        }
        .clipShape(RoundedRectangle(cornerRadius: .CRx5))
    }
}

// MARK: - Constants

extension DCategory {

    enum Constants {
        static let borderColor = Color(uiColor: UIColor(rgb: 0xEDEFF1))
    }
}
