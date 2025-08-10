import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    .Catalog,
    additionalTargets: [
        .interface(dependencies: [
            .module(.SharedUserStories),
            .module(.Coordinator)
        ]),
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
    ]
)
