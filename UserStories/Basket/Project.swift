import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    .Basket,
    additionalTargets: [
        .interface(dependencies: [
            .module(.SharedUserStories),
            .module(.Coordinator)
        ]),
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

        .interface(.Basket),
        .interface(.UserService),
        .interface(.CartService),
    ]
)
