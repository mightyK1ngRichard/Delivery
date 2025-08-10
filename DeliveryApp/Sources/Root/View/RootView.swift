//
//  Created by Dmitriy Permyakov on 06.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import SwiftUI
import DesignSystem
import Coordinator
import MainInterface

struct RootScreenView: View {

    @StateObject
    var state: RootScreenViewState

    let mainCoordinator: any AnyMainCoordinator

    var body: some View {
        TabView(selection: $state.tabItem) {
            NavigatableView(mainCoordinator)
                .contrasteTintTabItem(type: .house)

//            CoordinatorNavigationView(catalogCoordinator)
//                .contrasteTintTabItem(type: .catalog)

//            if let basketCoordinator {
//                CoordinatorNavigationView(basketCoordinator)
//                    .contrasteTintTabItem(type: .cart)
        //            .badge(mainViewModel.uiProperties.basketBadge)
//            }

//            CoordinatorNavigationView(profileCoordinator)
//                .contrasteTintTabItem(type: .profile)
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
