import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    .Basket,
    additionalTargets: [
        .example(dependencies: [
            .module(.Basket),
            .module(.Coordinator),
            .module(.DependencyRegistry)
        ])
    ],
    dependencies: [
        .module(.Resolver),
        .module(.Coordinator),
        .module(.DesignSystem),

        .module(.SharedUserStories),
        .interface(.SharedContracts),

        .interface(.UserService),
        .interface(.CartService),
    ]
)
