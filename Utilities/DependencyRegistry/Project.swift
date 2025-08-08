import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    .DependencyRegistry,
    additionalTargets: [],
    dependencies: [
        .module(.DLCore),
        .module(.AuthService),
        .module(.BannerService),
        .module(.CartService),
        .module(.CatalogService),
        .module(.OrderService),
        .module(.PopcatsService),
        .module(.ProductService),
        .module(.UserService),
    ]
)
