import ProjectDescription


extension TargetDependency {

    public static func module(_ module: Module) -> TargetDependency {
        .project(target: module.name, path: "\(module.folderPath)")
    }

    public static func interface(_ module: Module) -> TargetDependency {
        .target(for: module, targetKind: .interface)
    }

    public static func testing(_ module: Module) -> TargetDependency {
        .target(for: module, targetKind: .testing)
    }
}

// MARK: - Private

extension TargetDependency {

    private static func target(for module: Module, targetKind: AdditionalTarget.Kind) -> TargetDependency {
        .project(target: module.name + targetKind.name, path: "\(module.folderPath)")
    }
}
