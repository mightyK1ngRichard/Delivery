//
//  Created by Dmitriy Permyakov on 26.08.2024
//  Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

public struct StartLoadingView: View {

    public init() {}

    public var body: some View {
        LoadingView
    }

    var LoadingView: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let height = geo.size.height

            DLIcon.logo.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 207, height: 24)
                .offset(x: (width - 207) / 2, y: (height - 24) / 2)

            ProgressView()
                .tint(DLColor<IconPalette>.blue.color)
                .offset(x: width / 2, y: height - height / 4)
        }
        .background {
            DLIcon.gradientBG.image
                .resizable()
        }
        .preferredColorScheme(.light)
        .ignoresSafeArea()
    }
}

// MARK: - Preview

#Preview {
    StartLoadingView()
}
