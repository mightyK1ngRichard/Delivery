public enum Module: String, CaseIterable {

    case DLCore
    case DLNetwork
    case DesignSystem

    case AuthService
    case BannerService
    case CartService
    case CatalogService
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
        case .DLCore, .DLNetwork, .DesignSystem:
            return .utility
        case .AuthService, .BannerService, .CartService,
                .CatalogService:
            return .service
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
