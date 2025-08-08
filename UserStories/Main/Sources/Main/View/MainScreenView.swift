//
//  Created by Dmitriy Permyakov on 13.06.2024
//  Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI
import DLCore

struct MainScreenView: View {

    @StateObject
    var state: MainScreenViewState
    let output: MainScreenViewOutput

    @FocusState
    var isFocused: Bool

    var body: some View {
        mainContainer
            .onFirstAppear {
                output.onFirstAppear()
            }
    }
}

// MARK: - Constants

private extension MainScreenView {

    enum Constants {

        static let searchText = String(localized: "search").capitalized
    }
}
