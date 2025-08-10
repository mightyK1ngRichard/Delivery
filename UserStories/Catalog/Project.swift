import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    .Catalog,
    additionalTargets: [
        .example(dependencies: [
            .module(.Catalog),
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
        .interface(.ProductService),
        .interface(.CatalogService),
        .interface(.Main),
    ]
)
