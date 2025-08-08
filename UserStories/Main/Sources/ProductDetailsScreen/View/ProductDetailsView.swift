//
//  Created by Dmitriy Permyakov on 25.08.2024
//  Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI
import DesignSystem

struct ProductDetailsView: View {

    @ObservedObject
    var state: ProductDetailsScreenViewState
    let output: ProductDetailsViewOutput

    var body: some View {
        mainContainer
            .navigationBarTitleDisplayMode(.inline)
            .onFirstAppear(perform: output.onFirstAppear)
    }
}
