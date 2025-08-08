import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    .ProductService,
    additionalTargets: [
        .interface(dependencies: [
            .module(.DLCore),
            .interface(.SharedContracts),
        ])
    ],
    dependencies: [
        .module(.DLCore),
        .module(.DLNetwork),
        .interface(.SharedContracts),
    ]
)
