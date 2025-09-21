//
// DLStepper.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 28.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI
import DLCore

struct DLStepper: View {

    struct Configuration: Hashable {

        let counter: Int
        let magnifier: Int
    }

    struct HandlerConfiguration {

        let didTapPlus: DLVoidBlock?
        let didTapMinus: DLVoidBlock?
    }

    let configuration: Configuration
    var handlerConfiguration: HandlerConfiguration

    init(
        configuration: Configuration,
        handlerConfiguration: HandlerConfiguration
    ) {
        self.configuration = configuration
        self.handlerConfiguration = handlerConfiguration
    }

    var body: some View {
        StepperView
    }

    private var isDisable: Bool {
        configuration.magnifier > configuration.counter - configuration.magnifier
    }

    private var StepperView: some View {
        HStack(spacing: .SPx3) {
            Button {
//                counter = counter - configuration.magnifier
                handlerConfiguration.didTapMinus?()
            } label: {
                DLIcon.minus.image
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 16)
                    .foregroundStyle(
                        isDisable
                            ? DLColor<IconPalette>.white.color
                            : DLColor<IconPalette>.blue.color
                    )
                    .frame(maxHeight: .infinity)
            }
            .disabled(isDisable)

            Text("\(configuration.counter)")
                .style(size: 16, weight: .bold, color: DLColor<TextPalette>.primary.color)
                .frame(minWidth: 49)

            Button {
//                counter += configuration.magnifier
                handlerConfiguration.didTapPlus?()
            } label: {
                DLIcon.plus.image
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 16, height: 16)
                    .foregroundStyle(DLColor<IconPalette>.primary.color)
                    .frame(maxHeight: .infinity)
            }
        }
        .padding(.horizontal)
        .frame(height: 43)
        .background(DLColor<BackgroundPalette>.lightGray.color, in: .rect(cornerRadius: .CRx3))
    }
}
