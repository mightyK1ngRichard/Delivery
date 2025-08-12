//
//  Created by Dmitriy Permyakov on 12.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

@MainActor
public protocol ProfileOutput: AnyObject {
    func profileDidLogout()
    func didLoginSuccess() async
}
