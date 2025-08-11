//
//  Created by Dmitriy Permyakov on 26.08.2024
//  Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

public struct StartLoadingView: View {

    @State
    private var scale: CGFloat = 1.0

    public init() {}

    public var body: some View {
        DLIcon.logo.image
            .foregroundColor(.blue)
            .scaleEffect(scale)
            .onAppear {
                withAnimation(
                    .easeInOut(duration: 1.0)
                    .repeatForever(autoreverses: true)
                ) {
                    scale = 1.2
                }
            }
    }
}

// MARK: - Preview

#Preview {
    StartLoadingView()
}
