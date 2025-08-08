import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    .Coordinator,
    additionalTargets: [],
    dependencies: [
        .module(.DLCore)
    ]
)
