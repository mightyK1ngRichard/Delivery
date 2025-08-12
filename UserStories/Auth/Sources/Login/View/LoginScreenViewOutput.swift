//
//  Created by Dmitriy Permyakov on 28.06.2025
//  Copyright © 2025 Dostavka24. All rights reserved.
//

@MainActor
protocol LoginScreenViewOutput {
    func onFirstAppear()
    func onTapRememberMeButton()
    func onTapDontRememberPasswordButton()
    func onTapVisibility()
    func onTapSignInButton()
    func onTapCloseButton()
}
