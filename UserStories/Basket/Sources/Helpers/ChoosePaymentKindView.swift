//
//  Created by Dmitriy Permyakov on 12.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import SwiftUI
import DesignSystem
import BasketInterface

@MainActor
protocol ChoosePaymentKindViewOutput {
    func didSelectPaymentKind(_ paymentKind: PaymentKind)
}

struct ChoosePaymentKindView: View {

    @State
    var selectedItem: PaymentKind
    let output: ChoosePaymentKindViewOutput

    private let items: [PaymentKind] = PaymentKind.allCases

    var body: some View {
        VStack(spacing: .zero) {
            ForEach(items, id: \.self, content: itemView)

            Spacer()

            DLButton(configuration: .init(
                state: .default,
                hasDisabled: false,
                titleView: {
                    Text("Сохранить")
                        .style(size: 16, weight: .semibold, color: .white)
                },
                subtileView: { EmptyView() }
            )) {
                output.didSelectPaymentKind(selectedItem)
            }
        }
        .padding(.SPx4)
    }

    private func itemView(_ item: PaymentKind) -> some View {
        VStack(spacing: .zero) {
            HStack(spacing: .SPx4) {
                if item == selectedItem {
                    DLIcon.radiobuttonOn.image
                } else {
                    DLIcon.radiobuttonOff.image
                }

                Text(item.localized)
                    .style(size: 17, weight: .regular, color: .primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.vertical, 17)

            Divider()
        }
        .contentShape(.rect)
        .onTapGesture {
            selectedItem = item
        }
    }
}
