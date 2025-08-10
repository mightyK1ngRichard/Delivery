import ProjectDescription

extension Project {

    public static func basic(
        name: String,
        additionalTargets: [AdditionalTarget] = [],
        product: Product,
        bundleSuffix: String,
        infoPlist: InfoPlist = .default,
        resources: ResourceFileElements? = nil,
        dependencies: [TargetDependency] = [],
        targetDefaultSettingsExcluding: Set<String> = []
    ) -> Project {
        let bundleID = TargetSettings.mainBundleId.appending(".").appending(bundleSuffix)
        let target = makeTarget(
            name: name,
            product: product,
            bundleID: bundleID,
            infoPlist: infoPlist,
            resources: resources,
            scripts: [],
            dependencies: dependencies,
            defaultSettingsExcluding: targetDefaultSettingsExcluding
        )

        let additionalTargets: [(type: AdditionalTarget, target: Target)] = Array(
            zip(
                additionalTargets,
                AdditionalTargetFabric.makeAdditionalTargets(additionalTargets, for: name)
            )
        )


        return Project(
            name: name,
            organizationName: WorkspaceSettings.organizationName,
            classPrefix: WorkspaceSettings.classPrefix,
            settings: .baseSettings(),
            targets: [target] + additionalTargets.map(\.target)
        )
    }

    private static func makeTarget(
        name: String,
        product: Product,
        bundleID: String,
        infoPlist: InfoPlist,
        resources: ResourceFileElements?,
        scripts: [TargetScript],
        dependencies: [TargetDependency],
        defaultSettingsExcluding: Set<String>
    ) -> Target {
        .target(
            name: name,
            destinations: TargetSettings.destinations,
            product: product,
            bundleId: bundleID,
            deploymentTargets: TargetSettings.deploymentTargets,
            infoPlist: infoPlist,
            sources: "Sources/**",
            resources: resources,
            scripts: scripts,
            dependencies: dependencies,
            settings: Settings.settings(
                base: .baseTargetSettings,
                defaultSettings: .recommended(excluding: defaultSettingsExcluding)
            )
        )
    }
}
