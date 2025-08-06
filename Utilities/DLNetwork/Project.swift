import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    .DLNetwork,
    additionalTargets: [],
    dependencies: [
        .module(.DLCore),
    ]
)
