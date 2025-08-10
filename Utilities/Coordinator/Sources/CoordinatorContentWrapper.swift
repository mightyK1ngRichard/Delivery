//
//  Created by Eugene Kiselev on 03.04.2025.
//  Copyright © 2025 RWB LLC. All rights reserved.
//

import SwiftUI

struct CoordinatorContentWrapper<Route: Identifiable>: View where Route: Hashable {
    
    @StateObject
    private var storage: WrappedStorage = .init()
    
    @State
    private var wasFirstAppear: Bool = false
    
    private let coordinator: any Navigatable
    private let buildDestination: (Route) -> AnyView
    private let router: Router<Route>
    
    public init<C: Navigatable>(_ coordinator: C) where C.Route == Route {
        self.coordinator = coordinator
        router = coordinator.router
        buildDestination = { route in
            AnyView(coordinator.buildDestination(route))
        }
    }

    var body: some View {
        ZStack {
            if #available(iOS 17.0, *) {
                defaultContentWrapper
            } else {
                deprecatedContentWrapper
            }
        }
        .onAppear {
            guard !wasFirstAppear else { return }
            wasFirstAppear.toggle()
            storage.cachedRunDestination = AnyView(coordinator.run())
        }
    }
}

// MARK: - Helpers

extension CoordinatorContentWrapper {
    
    private var defaultContentWrapper: some View {
        storage.cachedRunDestination
            .toolbar(.hidden)
            .navigationDestination(
                for: Route.self
            ) { route in
                buildDestination(route)
                    .toolbar(.hidden)
                    .background(EnablePopGestureEditor())
            }
    }
    
    // swiftlint:disable redundant_discardable_let
    // iOS 16 имеет багнутую навигацию, костылим для него
    private var deprecatedContentWrapper: some View {
        storage.cachedRunDestination
            .toolbar(.hidden)
            .navigationDestination(
                for: Route.self
            ) { route in
                if let destination = storage.destinations.first(where: { $0.route.hashValue == route.hashValue }) {
                    destination.cachedDestination
                } else {
                    let destination = buildDestination(route)
                        .toolbar(.hidden)
                    
                    let _ = storage.destinations.append(.init(
                        route: route,
                        cachedDestination: AnyView(destination)
                    ))
                    
                    destination
                }
            }
            .onReceive(router.$path) {
                storage.destinations = Array(storage.destinations.prefix($0.count))
            }
    }
    // swiftlint:enable redundant_discardable_let
}

// MARK: - WrappedStorage (for ios 16)

extension CoordinatorContentWrapper {
    
    private final class WrappedStorage: ObservableObject {
        @Published
        var cachedRunDestination: AnyView?
        
        var destinations: [Destination] = []
        
        struct Destination {
            let route: Route
            let cachedDestination: AnyView
        }
    }
}

// MARK: - CoordinatorContentWrapper + Equatable

extension CoordinatorContentWrapper: @preconcurrency Equatable {
    static func == (_: Self, _: Self) -> Bool {
        true
    }
}
