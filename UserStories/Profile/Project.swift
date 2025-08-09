import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    .Profile,
    additionalTargets: [
        .interface(),
        .example(dependencies: [
            .module(.Profile),
            .module(.DependencyRegistry)
        ])
    ],
    dependencies: [
        .module(.Resolver),
        .module(.DLNetwork),
        .module(.DesignSystem),
        .module(.Coordinator),
        .module(.SharedUserStories),

        .interface(.UserService),
        .interface(.OrderService),
    ]
)
