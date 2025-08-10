//
//  Created by Dmitriy Permyakov on 06.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import SwiftUI
import DesignSystem
import Coordinator
import MainInterface
import CatalogInterface
import ProfileInterface
import BasketInterface

struct RootScreenView: View {

    @StateObject
    var state: RootScreenViewState

    let mainCoordinator: any AnyMainCoordinator
    let catalogCoordinator: any AnyCatalogCoordinator
    let profileCoordinator: any AnyProfileCoordinator
    let basketCoordinator: any AnyBasketCoordinator

    var body: some View {
        TabView(selection: $state.tabItem) {
            NavigatableView(mainCoordinator)
                .contrasteTintTabItem(type: .house)

            NavigatableView(catalogCoordinator)
                .contrasteTintTabItem(type: .catalog)

            if state.showBasketFlow {
                NavigatableView(basketCoordinator)
                    .contrasteTintTabItem(type: .cart)
                    .badge(state.basketBadge.isEmpty ? nil : state.basketBadge)
            }

            NavigatableView(profileCoordinator)
                .contrasteTintTabItem(type: .profile)
        }
        .tint(DLColor<IconPalette>.primary.color)
    }
}

// MARK: - Helper

extension View {

    fileprivate func contrasteTintTabItem(type: TabBarItem) -> some View {
        tabItem {
            VStack {
                type.image
                    .renderingMode(.template)
                Text(type.rawValue)
                    .font(.system(size: 10, weight: .medium))
            }
        }
        .tint(DLColor<IconPalette>.primary.color)
        .tag(type)
    }
}
