import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    .Category,
    additionalTargets: [
        .example(dependencies: [
            .module(.Category),
            .module(.DependencyRegistry)
        ])
    ],
    dependencies: [
        .module(.Resolver),
        .module(.DesignSystem),
        .interface(.SharedContracts),
        .interface(.ProductService),
        .interface(.CatalogService),
        .module(.SharedUserStories),
    ]
)
