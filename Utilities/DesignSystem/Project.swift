import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    .DesignSystem,
    additionalTargets: [],
    dependencies: [
        .module(.DLCore),
    ]
)
