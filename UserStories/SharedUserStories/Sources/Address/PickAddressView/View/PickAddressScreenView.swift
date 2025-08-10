//
//  Created by Dmitriy Permyakov on 13.08.2024
//  Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

struct PickAddressScreenView: View {

    @StateObject
    var state: PickAddressScreenViewState
    let output: PickAddressViewOutput

    var body: some View {
        mainContainer.onFirstAppear {
            output.onFirstAppear()
        }
    }
}
