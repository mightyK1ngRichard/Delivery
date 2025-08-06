import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    .CartService,
    additionalTargets: [
        .interface()
    ],
    dependencies: [
        .module(.DLCore),
        .module(.DLNetwork),
    ]
)
