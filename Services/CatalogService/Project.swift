import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    .CatalogService,
    additionalTargets: [
        .interface()
    ],
    dependencies: [
        .module(.DLCore),
        .module(.DLNetwork),
    ]
)
