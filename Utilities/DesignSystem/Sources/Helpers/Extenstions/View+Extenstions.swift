//
//  Created by Dmitriy Permyakov on 05.08.2025.
//  Copyright © 2025 Dostavka24. All rights reserved.
//

import SwiftUI
import Resolver
import DLNetwork

struct OnFirstAppearModifier: ViewModifier {

    @State
    private var firstTime = true

    let perform: () -> Void

    func body(content: Content) -> some View {
        content
            .onAppear {
                guard firstTime else { return }
                firstTime = false
                perform()
            }
    }
}

public extension View {

    func onFirstAppear(perform: @escaping () -> Void) -> some View {
        modifier(OnFirstAppearModifier(perform: perform))
    }
}

private struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

extension View {

    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }

    @ViewBuilder
    func hidden(_ isHidden: Bool) -> some View {
        if isHidden {
            hidden()
        } else {
            self
        }
    }
}

// MARK: - BindSize

extension View {

    @ViewBuilder
    public func bindSize(_ size: Binding<CGSize>) -> some View {
        if #available(iOS 16.0, *) {
            onGeometryChange(for: CGSize.self) { proxy in
                proxy.size
            } action: { newValue in
                size.wrappedValue = newValue
            }
        } else {
            background(
                GeometryReader { geometryProxy in
                    Color.clear
                        .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
                }
            )
            .onPreferenceChange(SizePreferenceKey.self) { newSize in
                size.wrappedValue = newSize
            }
        }
    }
}

private struct SizePreferenceKey: PreferenceKey {

    static let defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}

// MARK: - OffsetKey

struct OffsetKey: PreferenceKey {
    static let defaultValue: CGRect = .zero

    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

extension View {

    func offsetX(_ addObserver: Bool, completion: @escaping (CGRect) -> Void) -> some View {
        frame(maxWidth: .infinity)
            .overlay {
                if addObserver {
                    GeometryReader {
                        let rect = $0.frame(in: .global)

                        Color.clear
                            .preference(key: OffsetKey.self, value: rect)
                            .onPreferenceChange(OffsetKey.self, perform: completion)
                    }
                }
            }
    }
}
