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

    let output: RootScreenViewOutput

    var body: some View {
        Group {
            switch state.screenState {
            case .loading:
                loadingView
            case .content:
                content
            case .error:
                ErrorView(title: "Ошибка загрузки приложения")
            }
        }
        .onFirstAppear(perform: output.onFirstAppear)
    }
}

extension RootScreenView {

    var loadingView: some View {
        StartLoadingView()
    }

    var content: some View {
        TabView(selection: $state.tabItem) {
            NavigatableView(mainCoordinator)
                .contrasteTintTabItem(type: .house)

            NavigatableView(catalogCoordinator)
                .contrasteTintTabItem(type: .catalog)

            if state.showBasketFlow {
                NavigatableView(basketCoordinator)
                    .contrasteTintTabItem(type: .cart)
                    .badge(state.basketBadge == 0 ? nil : String(state.basketBadge))
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
                Text(type.locolized)
                    .font(.system(size: 10, weight: .medium))
            }
        }
        .tint(DLColor<IconPalette>.primary.color)
        .tag(type)
    }
}
