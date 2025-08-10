//
// DLCheckbox.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 13.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI
import DLCore

public struct DLCheckbox: View {

    public struct Configuration {

        let isSelected: Bool

        public init(isSelected: Bool) {
            self.isSelected = isSelected
        }
    }

    private let configuration: Configuration
    private let action: DLBoolBlock?

    public init(configuration: Configuration, action: DLBoolBlock? = nil) {
        self.configuration = configuration
        self.action = action
    }

    public var body: some View {
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
