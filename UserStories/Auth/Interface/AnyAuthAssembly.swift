//
//  Created by Dmitriy Permyakov on 12.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import SwiftUI

@MainActor
public protocol AnyAuthAssembly {

    func assemble(route: AuthRoute, output: AuthOutput) -> any AnyAuthCoordinator
}
