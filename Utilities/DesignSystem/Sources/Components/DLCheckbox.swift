//
// DLCheckbox.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 13.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI
import DLCore

struct DLCheckbox: View {
    struct Configuration {
        var isSelected: Bool
    }

    var configuration: Configuration
    var action: DLBoolBlock?

    var body: some View {
        Button {
            action?(!configuration.isSelected)
        } label: {
            MainBlock
        }
    }

    @ViewBuilder
    private var MainBlock: some View {
        if configuration.isSelected {
            DLIcon.radiobuttonOn.image
                .frame(width: 24, height: 24)
        } else {
            DLIcon.radiobuttonOff.image
                .frame(width: 24, height: 24)
        }
    }
}

#Preview {
    DLCheckbox(configuration: .init(isSelected: true))
}
