//
//  Created by Dmitriy Permyakov on 08.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import SwiftUI

public enum DLIcon: String, CaseIterable {

    case backButton
    case checkMark
    case bottomChevron
    case box
    case checkboxOff
    case checkboxOn
    case chivronBottom
    case chivronRight
    case close
    case cryingEmoji
    case done
    case filledLike
    case like
    case minus
    case money
    case plus
    case car
    case faq
    case favorite
    case feedback
    case radiobuttonOn
    case radiobuttonOff
    case gradientBG = "GradientBG"
    case info
    case map
    case profile
    case quit
    case telegramBot
    case reload
    case share
    case heart
    case slider
    case sort
    case time
    case trash
    case visibilityOff
    case visibilityOn
    case warning
    case xmark
    case logo
    case cart
    case home
    case magnifier
    case profileBar
    case discount
    case hits
    case new
}

extension DLIcon {

    public var image: Image {
        Image(rawValue, bundle: .module)
    }

    public static func image(resource: String) -> Image {
        Image(resource, bundle: .module)
    }
}
