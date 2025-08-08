import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    .SharedContracts,
    additionalTargets: [
        .interface()
    ],
    dependencies: [
        .module(.DLCore),
        .module(.DLNetwork)
    ]
)
