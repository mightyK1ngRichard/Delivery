import ProjectDescription

enum AdditionalTargetFabric {

    static func makeAdditionalTargets(_ targets: [AdditionalTarget], for projectName: String) -> [Target] {
        targets.map { makeAdditionalTarget($0, for: projectName, allProjectTargets: targets) }
    }

    static func makeAdditionalTarget(
        _ target: AdditionalTarget,
        for projectName: String,
        allProjectTargets: [AdditionalTarget]
    ) -> Target {
        switch target.kind {
        case .interface:
            return makeAdditionalTarget(
                target,
                for: projectName,
                product: .module
            )

        case .testing:
            var dependencies: [TargetDependency] = [.target(name: projectName)]
            allProjectTargets.filter { [.interface].contains($0.kind) }.forEach { target in
                dependencies.append(.target(name: target.kind.makeFullName(for: projectName)))
            }

            return makeAdditionalTarget(
                target,
                for: projectName,
                product: .module,
                deploymentTargets: TargetSettings.deploymentTestingTargets,
                dependencies: dependencies
            )

        case .unitTests:
            var dependencies: [TargetDependency] = [.target(name: projectName)]
            allProjectTargets.filter { [.testing, .interface].contains($0.kind) }.forEach { target in
                dependencies.append(.target(name: target.kind.makeFullName(for: projectName)))
            }

            return makeAdditionalTarget(
                target,
                for: projectName,
                product: .unitTests,
                deploymentTargets: TargetSettings.deploymentTestingTargets,
                dependencies: dependencies
            )
        }
    }

    /// Создает дополнительный таргет к модулю.
    private static func makeAdditionalTarget(
        _ target: AdditionalTarget,
        for moduleName: String,
        product: Product,
        deploymentTargets: DeploymentTargets = TargetSettings.deploymentTargets,
        resources: [String]? = nil,
        dependencies: [TargetDependency] = [],
        infoPlist: [String: Plist.Value]? = nil
    ) -> Target {
        let folderName = target.kind.folderName

        return Target.target(
            name: target.kind.makeFullName(for: moduleName),
            destinations: TargetSettings.destinations,
            product: product,
            bundleId: target.kind.makeBundleId(for: moduleName),
            deploymentTargets: deploymentTargets,
            infoPlist: infoPlist.flatMap { .extendingDefault(with: $0) } ?? .default,
            sources: "\(folderName)/**",
            resources: .resources(resources, folderName: folderName),
            dependencies: target.dependencies + dependencies
        )
    }
}

// MARK: - ResourceFileElements.resources

extension ResourceFileElements {

    fileprivate static func resources(_ paths: [String]?, folderName: String) -> ResourceFileElements? {
        paths.flatMap { .resources($0, folderName: folderName) }
    }

    fileprivate static func resources(_ paths: [String], folderName: String) -> ResourceFileElements {
        .resources(paths.map { "\(folderName)/\($0)" })
    }
}
