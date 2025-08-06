//
//  Created by Dmitriy Permyakov on 06.08.2025.
//  Copyright © 2025 Delivery. All rights reserved.
//

import ProjectDescription

let baseBundleID = "com.mightykingrichard.DeliveryApp"

extension Target {

    public enum Demo: String, CaseIterable {
        case app = "DeliveryApp"
    }
}

extension Target.Demo {

    public var target: Target {
        .target(
            name: rawValue,
            destinations: .iOS,
            product: .app,
            bundleId: "\(baseBundleID).\(rawValue)",
            deploymentTargets: .iOS("16.0"),
            sources: ["Sources/**"],
            resources: ["Resources/**"]
        )
    }

    public var unitTest: Target {
        .target(
            name: "\(rawValue) - UnitTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "\(baseBundleID).\(rawValue)Tests",
            deploymentTargets: .iOS("16.0"),
            sources: ["Tests/**"]
        )
    }
}
