//
//  Created by Dmitriy Permyakov on 09.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import Coordinator
import SwiftUI

public enum MainAssembly {

    @MainActor
    public static func assemble() -> AnyView {
        AnyView(
            NavigatableView(coordinator: MainCoordinator(router: .init()))
        )
    }
}
