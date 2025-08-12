import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    .Auth,
    additionalTargets: [
        .interface(dependencies: [
            .module(.SharedUserStories),
        ]),
        .example(dependencies: [
            .module(.Auth),
            .module(.Coordinator),
            .module(.DependencyRegistry)
        ])
    ],
    dependencies: [
        .module(.Resolver),
        .module(.Coordinator),
        .module(.DesignSystem),
        .interface(.AuthService),
        .module(.SharedUserStories),
    ]
)
