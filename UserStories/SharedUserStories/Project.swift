import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    .SharedUserStories,
    additionalTargets: [],
    dependencies: [
        .module(.DesignSystem),
        .interface(.SharedContracts),
    ]
)
