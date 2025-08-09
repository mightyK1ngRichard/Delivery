import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    .SharedUserStories,
    additionalTargets: [],
    dependencies: [
        .module(.DLCore),
        .module(.DesignSystem),
        .interface(.SharedContracts),
    ]
)
