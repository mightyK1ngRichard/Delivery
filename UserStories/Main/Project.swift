import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    .Main,
    additionalTargets: [
        .interface(),
        .example(dependencies: [
            .module(.Main),
            .module(.DependencyRegistry)
        ])
    ],
    dependencies: [
        .module(.Resolver),
        .module(.DLNetwork),
        .module(.DesignSystem),

        .interface(.ProductService),
        .interface(.BannerService),
        .interface(.UserService),
        .interface(.CartService),
        .interface(.PopcatsService),
    ]
)
