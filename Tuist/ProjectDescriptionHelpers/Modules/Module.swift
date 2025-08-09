public enum Module: String, CaseIterable {

    // L1
    case DLCore

    // L2
    case DLNetwork
    case DesignSystem

    // L3
    case AuthService
    case BannerService
    case CartService
    case CatalogService
    case OrderService
    case PopcatsService
    case ProductService
    case UserService

    // L4
    case SharedContracts

    // L5
    case Resolver

    // L6
    case DependencyRegistry
    case Coordinator

    // L7
    case Main
    case Profile
    // L8
    case SharedUserStories
}

// MARK: - Kind

extension Module {

    enum Kind {
        case userStory
        case utility
        case service
    }
}

extension Module {

    var name: String {
        rawValue
    }

    var kind: Kind {
        switch self {
        case .DLCore, .DLNetwork, .DesignSystem, .Resolver,
                .DependencyRegistry, .Coordinator:
            return .utility
        case .AuthService, .BannerService, .CartService,
                .CatalogService, .OrderService, .PopcatsService,
                .ProductService, .UserService, .SharedContracts:
            return .service
        case .Main, .Profile, .SharedUserStories:
            return .userStory
        }
    }

    var folderPath: String {
        "\(kind.folderName)/\(name)"
    }
}

extension Module.Kind {

    /// **Пример:**
    /// `//Utilities/Network`
    var folderName: String {
        switch self {
        case .userStory:
            "//UserStories"
        case .utility:
            "//Utilities"
        case .service:
            "//Services"
        }
    }
}
