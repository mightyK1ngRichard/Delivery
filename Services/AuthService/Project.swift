import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    .AuthService,
    additionalTargets: [
        .interface()
    ],
    dependencies: [
        .module(.DLCore),
        .module(.DLNetwork),
    ]
)
