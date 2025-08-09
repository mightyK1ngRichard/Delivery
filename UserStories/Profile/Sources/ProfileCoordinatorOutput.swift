//
//  Created by Dmitriy Permyakov on 30.06.2025
//  Copyright © 2025 Dostavka24. All rights reserved.
//

@MainActor
protocol ProfileCoordinatorOutput: AnyObject {
    func userDidLogout()
    func userDidLogIn()
    func userRegistered()
}
