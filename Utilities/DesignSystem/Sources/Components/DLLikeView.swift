//
// DLLikeView.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 29.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI
import DLCore

struct DLLikeView: View {
    @State private var isLiked = false
    var didTapLike: DLBoolBlock?

    init(isLiked: Bool, didTapLike: DLBoolBlock? = nil) {
        self._isLiked = State(initialValue: isLiked)
        self.didTapLike = didTapLike
    }

    var body: some View {
        LikeButton
    }

    private var LikeButton: some View {
        Button {
            isLiked.toggle()
            didTapLike?(isLiked)
        } label: {
            Image(isLiked ? .filledLike : .like)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 16, height: 16)
                .padding(10)
                .frame(width: 36, height: 36)
        }
        .background(DLColor<BackgroundPalette>.white.color, in: .circle)
    }
}

#Preview {
    DLLikeView(isLiked: true)
}
