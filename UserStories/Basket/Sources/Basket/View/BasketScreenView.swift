//
//  Created by Dmitriy Permyakov on 09.07.2024
//  Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI
import DesignSystem

struct BasketScreenView: View {

    @StateObject
    var state: BasketViewState
    let output: BasketScreenViewOutput

    var body: some View {
        mainContainer
            .onFirstAppear(perform: output.onFirstAppear)
            .onAppear(perform: output.onAppear)
    }
}
