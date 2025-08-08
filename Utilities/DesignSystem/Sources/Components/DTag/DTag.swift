//
// DTag.swift
// iOS-Delivery24
//
// Created by Garbuzov Matvey on 16.06.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

public struct DTag: View {

    var tags: Tags
    var title: String

    public init(tags: Tags, title: String) {
        self.tags = tags
        self.title = title
    }

    public var body: some View {
        HStack(spacing: .SPx2) {
            if let icon = tags.icon {
                icon
                    .renderingMode(.template)
                    .foregroundStyle(
                        tags == .hit
                            ? Color("TagHitsIcon", bundle: .module)
                            : Color("Contraste", bundle: .module)
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
