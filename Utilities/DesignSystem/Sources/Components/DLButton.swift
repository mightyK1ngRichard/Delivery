//
// DLButton.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 26.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI
import DLCore

public enum ButtonState {
    case `default`
    case loading
}

public struct DLButton<
    TitleContent: View,
    SubtitleContent: View
>: View {
    public struct Configuration {
        var state: ButtonState
        var titleView: TitleContent
        var subtileView: SubtitleContent?
        var hasDisabled: Bool
        private(set) var vPadding: CGFloat

        public init(
            state: ButtonState = .default,
            hasDisabled: Bool,
            titleView: () -> TitleContent,
            subtileView: (() -> SubtitleContent)?
        ) {
            self.state = state
            self.hasDisabled = hasDisabled
            self.titleView = titleView()
            self.subtileView = subtileView?()
            self.vPadding = self.subtileView is EmptyView ? 22 : 12
        }
    }

    let configuration: Configuration
    let action: DLVoidBlock?

    public init(
        configuration: Configuration,
        action: DLVoidBlock? = nil
    ) {
        self.configuration = configuration
        self.action = action
    }

    public var body: some View {
        Button {
            guard !isHidden else { return }
            action?()
        } label: {
            VStack(spacing: .SPx0_5) {
                configuration.titleView.hidden(isHidden)
                if let subtitleView = configuration.subtileView {
                    subtitleView.hidden(isHidden)
                }
            }
            .padding(.vertical, configuration.vPadding)
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
            .overlay {
                ProgressView()
                    .tint(DLColor<IconPalette>.white.color)
                    .hidden(!isHidden)
            }
        }
        .buttonStyle(ButtonStyleView(hasDisabled: configuration.hasDisabled))
        .disabled(configuration.hasDisabled || isHidden)
    }

    private var isHidden: Bool {
        configuration.state == .loading
    }
}

extension DLButton.Configuration where SubtitleContent == EmptyView {

    init(
        state: ButtonState = .default,
        hasDisabled: Bool,
        @ViewBuilder titleView: () -> TitleContent
    ) {
        self.state = state
        self.hasDisabled = hasDisabled
        self.titleView = titleView()
        self.subtileView = nil
        self.vPadding = 22
    }
}

// MARK: - Preview

@available(iOS 17, *)
#Preview {
    VStack {
        DLButton(
            configuration: .init(
                state: .loading,
                hasDisabled: false,
                titleView: {
                    Text("Title")
                        .style(size: 16, weight: .medium, color: .white)
                }, subtileView: {
                    Text("Subtitle")
                        .style(size: 12, weight: .light, color: .white)
                }
            )
        ) { print("[DEBUG]: did tap") }
            .padding(.horizontal)

        DLButton(
            configuration: .init(
                hasDisabled: false,
                titleView: {
                    Text("Title")
                        .style(size: 16, weight: .medium, color: .white)
                }, subtileView: {
                    Text("Subtitle")
                        .style(size: 12, weight: .light, color: .white)
                }
            )
        ) { print("[DEBUG]: did tap") }
            .padding(.horizontal)
    }
}

@available(iOS 17, *)
#Preview {
    DLButton(
        configuration: .init(
            hasDisabled: true,
            titleView: {
                Text("Text")
            }
        )
    )
    .padding(.horizontal)
}

// MARK: - Helper

private struct ButtonStyleView: ButtonStyle {

    private let bgColor = DLColor<BackgroundPalette>.blue.color
    private let bgLightColor = DLColor<BackgroundPalette>(
        hexLight: 0x181B67,
        hexDark: 0x181B67
    ).color
    var hasDisabled: Bool

    func makeBody(configuration: Configuration) -> some View {
        let isPressedColor = configuration.isPressed ? bgLightColor : bgColor
        let disabledColor = DLColor<BackgroundPalette>.lightGray2.color

        return configuration.label
            .background(
                hasDisabled ? disabledColor : isPressedColor,
                in: .rect(cornerRadius: 12)
            )
    }
}
