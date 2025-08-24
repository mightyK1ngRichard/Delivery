//
//  Created by Dmitriy Permyakov on 23.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import SwiftUI

extension View {

    public func alert(_ model: AlertModel, showAlert: Binding<Bool>) -> some View {
        alert(model.title, isPresented: showAlert) {
            Button("Хорошо") {}
        } message: {
            Text(model.subtitle)
        }
    }
}
