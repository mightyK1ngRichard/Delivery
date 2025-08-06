import ProjectDescription

public struct AdditionalTarget {

    let kind: Kind
    let dependencies: [TargetDependency]
}

// MARK: - Kind

extension AdditionalTarget {

    public enum Kind: CaseIterable, Equatable {
        case interface
        case unitTests
        case testing
    }
}

extension AdditionalTarget.Kind {

    var name: String {
        switch self {
        case .interface:
            "Interface"
        case .testing:
            "Testing"
        case .unitTests:
            "UnitTests"
        }
    }

    var folderName: String {
        name
    }

    func makeFullName(for moduleName: String) -> String {
        "\(moduleName)\(name)"
    }

    func makeBundleId(for projectName: String) -> String {
        "\(TargetSettings.mainBundleId).\(projectName.lowercased()).\(name.lowercased())"
    }
}

extension AdditionalTarget {

    public static func testing(dependencies: [TargetDependency] = []) -> Self {
        .init(kind: .testing, dependencies: dependencies)
    }

    public static func interface(dependencies: [TargetDependency] = []) -> Self {
        .init(kind: .interface, dependencies: dependencies)
    }
}
