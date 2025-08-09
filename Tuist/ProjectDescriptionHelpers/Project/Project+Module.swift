import Foundation
import ProjectDescription

extension Project {

    public static func module(
        _ module: Module,
        packages: [Package] = [],
        additionalTargets: [AdditionalTarget],
        product: Product = .module,
        resources: ResourceFileElements? = nil,
        resourceSynthesizers: [ResourceSynthesizer] = [],
        dependencies: [TargetDependency] = []
    ) -> Project {
        let mergedDependencies: [TargetDependency] = switch module.kind {
        case .utility, .service:
            dependencies
        case .userStory:
            dependencies + .commonUserStoriesModuleDependencies
        }
        let targets = makeTargets(
            for: module,
            additionalTargets: additionalTargets,
            product: product,
            resources: resources,
            dependencies: mergedDependencies
        )

        return Project(
            name: module.name,
            organizationName: WorkspaceSettings.organizationName,
            classPrefix: WorkspaceSettings.classPrefix,
            packages: packages,
            settings: .baseSettings(),
            targets: targets,
            resourceSynthesizers: resourceSynthesizers
        )
    }
}

extension Project {

    private static func makeTargets(
        for module: Module,
        additionalTargets: [AdditionalTarget],
        product: Product,
        resources: ResourceFileElements?,
        dependencies: [TargetDependency]
    ) -> [Target] {
        [makeMainTarget(
            for: module,
            additionalTargets: additionalTargets,
            product: product,
            resources: resources,
            dependencies: dependencies
        )] + AdditionalTargetFabric.makeAdditionalTargets(
            additionalTargets,
            for: module.name
        )
    }

}

// MARK: - Common

extension [TargetDependency] {

    /// Список общих зависимостей UserStories-модулей
    static let commonUserStoriesModuleDependencies: [TargetDependency] = [
        .module(.DLCore)
    ]
}

// MARK: - Targets Making

extension Project {

    /// Создание основного таргета модуля
    private static func makeMainTarget(
        for module: Module,
        additionalTargets: [AdditionalTarget],
        product: Product,
        resources: ResourceFileElements?,
        dependencies: [TargetDependency]
    ) -> Target {
        Target.target(
            name: module.name,
            destinations: TargetSettings.destinations,
            product: product,
            bundleId: "\(TargetSettings.mainBundleId).\(module.name.lowercased())",
            deploymentTargets: TargetSettings.deploymentTargets,
            infoPlist: .default,
            sources: "Sources/**",
            resources: resources,
            dependencies: dependencies + (
                additionalTargets.contains { $0.kind == .interface } ? [.interface(module)] : []
            ),
            settings: .baseSettings()
        )
    }
}
