//
//  Created by Dmitriy Permyakov on 13.06.2024
//  Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

extension Text {

    public enum TypographyWeight: Int {
        /// 100pt
        case thin = 100
        /// 200pt
        case ultraLight = 200
        /// 300pt
        case light = 300
        /// 400pt
        case regular = 400
        /// 500pt
        case medium = 500
        /// 600pt
        case semibold = 600
        /// 700pt
        case bold = 700
        /// 800pt
        case heavy = 800
        /// 900pt
        case black = 900

        var weight: Font.Weight {
            switch self {
            case .thin:
                return .thin
            case .ultraLight:
                return .ultraLight
            case .light:
                return .light
            case .regular:
                return .regular
            case .medium:
                return .medium
            case .semibold:
                return .semibold
            case .bold:
                return .bold
            case .heavy:
                return .heavy
            case .black:
                return .black
            }
        }
    }

    public func style(size: CGFloat, weight: TypographyWeight, color: Color) -> some View {
        font(.system(size: size, weight: weight.weight))
            .foregroundStyle(color)
    }
}
