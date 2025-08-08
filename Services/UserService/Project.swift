import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    .UserService,
    additionalTargets: [
        .interface(dependencies: [
            .interface(.SharedContracts),
            .module(.DLCore)
        ])
    ],
    dependencies: [
        .module(.DLCore),
        .module(.DLNetwork),
        .interface(.SharedContracts),
    ]
)
