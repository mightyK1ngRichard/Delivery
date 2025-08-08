//
//  Created by Dmitriy Permyakov on 07.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

public enum ScreenState: Identifiable, Hashable {

    case loading
    case content
    case error
}

extension ScreenState {

    public var id: Self { self }
}
