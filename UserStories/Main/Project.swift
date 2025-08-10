import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    .Main,
    additionalTargets: [
        .interface(dependencies: [
            .module(.Coordinator),
            .module(.SharedUserStories)
        ]),
        .example(dependencies: [
            .interface(.Main),
            .module(.DependencyRegistry)
        ])
    ],
    dependencies: [
        .module(.Resolver),
        .module(.DLNetwork),
        .module(.DesignSystem),
        .module(.Coordinator),
        .module(.SharedUserStories),
        
        .interface(.ProductService),
        .interface(.BannerService),
        .interface(.UserService),
        .interface(.CartService),
        .interface(.PopcatsService),
    ]
)
