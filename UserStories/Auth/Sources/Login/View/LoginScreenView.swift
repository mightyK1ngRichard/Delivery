//
//  Created by Dmitriy Permyakov on 27.08.2024
//  Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

struct LoginScreenView: View {

    @StateObject
    var state: LoginScreenViewState
    let output: LoginScreenViewOutput

    var body: some View {
        mainContainer.onFirstAppear {
            output.onFirstAppear()
        }
    }
}
