//
//  Created by Dmitriy Permyakov on 13.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import SwiftUI
import Resolver
import DLNetwork
import DesignSystem

extension View {

    public func basicToolBarItems(addressHandler: @escaping () -> Void) -> some View {
        modifier(BasicToolBarModifier(addressHandler: addressHandler))
    }
}

struct BasicToolBarModifier: ViewModifier {

    let addressHandler: () -> Void
    @State private var token: String?
    @State private var addressTitle: String?
    @State private var balance: Double?

    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItems()
            }
            .task {
                let networkStore = Resolver.resolve(AnyNetworkStore.self)
                token = await networkStore.token
                addressTitle = await networkStore.address?.title
                balance = await networkStore.balance
            }
    }

    @ToolbarContentBuilder
    func ToolbarItems() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            if token != nil {
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
        }

        ToolbarItem(placement: .topBarTrailing) {
            if let balance = balance {
                WalletView(moneyCount: String(balance))
            }
        }
    }
}
