//
//  Created by Dmitriy Permyakov on 24.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import SwiftUI
import DesignSystem

struct FormOrderSuccessView: View {

    var action: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: .SPx2) {
            Text(Constants.navigationTitle)
                .style(size: 34, weight: .bold, color: Constants.textPrimary)

            Text(Constants.title)
                .style(size: 17, weight: .regular, color: Constants.textPrimary)

            Spacer()

            DLButton(configuration: .init(
                hasDisabled: false,
                titleView: {
                    Text(Constants.buttonTitle)
                        .style(size: 16, weight: .semibold, color: Constants.textWhite)
                },
                subtileView: { EmptyView() }
            ), action: action)
        }
        .padding(.top, 3)
        .padding(.horizontal)
        .overlay {
            DLIcon.done.image
        }
    }
}

// MARK: - Preview

#Preview {
    FormOrderSuccessView {}
}

// MARK: - Constants

private extension FormOrderSuccessView {

    enum Constants {
        static let navigationTitle = String(localized: "Спасибо за заказ")
        static let title = String(localized: "Менеджер свяжется с вами в ближайшее время")
        static let buttonTitle = String(localized: "В каталог")
        static let bgButtonColor = DLColor<BackgroundPalette>.blue.color
        static let textWhite = DLColor<TextPalette>.white.color
        static let textPrimary = DLColor<TextPalette>.primary.color
    }
}
