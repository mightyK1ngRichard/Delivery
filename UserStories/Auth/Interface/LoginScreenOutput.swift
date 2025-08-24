//
//  Created by Dmitriy Permyakov on 28.06.2025
//  Copyright © 2025 Dostavka24. All rights reserved.
//

import SharedUserStories

@MainActor
public protocol LoginScreenOutput: AnyObject {
    func authScreenDidSignInSuccess()
    func authScreenDidClose()
}
