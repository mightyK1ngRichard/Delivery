//
//  Created by Dmitriy Permyakov on 13.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import SwiftUI
import Resolver
import DLNetwork
import DesignSystem

extension View {

    public func basicToolBarItems(
        addressTitle: String?,
        balance: String?,
        addressHandler: @escaping () -> Void
    ) -> some View {
        modifier(BasicToolBarModifier(
            addressTitle: addressTitle,
            balance: balance,
            addressHandler: addressHandler
        ))
    }
}

struct BasicToolBarModifier: ViewModifier {

    let addressTitle: String?
    let balance: String?
    let addressHandler: () -> Void

    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItems()
            }
    }

    @ToolbarContentBuilder
    func ToolbarItems() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button {
                addressHandler()
            } label: {
                HStack(spacing: 4) {
                    Text(addressTitle ?? "Укажите адрес доставки")
                        .style(size: 11, weight: .semibold, color: DLColor<TextPalette>.primary.color)

                    DLIcon.bottomChevron.image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 12, height: 12)
                }
            }
        }

        ToolbarItem(placement: .topBarTrailing) {
            if let balance = balance {
                WalletView(moneyCount: balance)
            }
        }
    }
}
