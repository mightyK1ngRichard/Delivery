//
//  Created by Dmitriy Permyakov on 01.09.2024
//  Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

struct CatalogProductsView: View {

    @StateObject
    var state: CatalogProductsState
    var output: CatalogProductsViewOutput

    var body: some View {
        mainContainer.onFirstAppear {
            output.onFirstAppear()
        }
    }
}
