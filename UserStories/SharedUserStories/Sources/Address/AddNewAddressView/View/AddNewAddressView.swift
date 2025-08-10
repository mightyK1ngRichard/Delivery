//
//  Created by Dmitriy Permyakov on 13.08.2024
//  Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

struct AddNewAddressView: View {

    @StateObject
    var state: AddNewAddressState
    let output: AddNewAddressViewOutput

    var body: some View {
        mainContainer.onFirstAppear {
            output.onFirstAppear()
        }
    }
}
