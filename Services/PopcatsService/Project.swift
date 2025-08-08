import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    .PopcatsService,
    additionalTargets: [
        .interface(dependencies: [
            .module(.DLCore)
        ])
    ],
    dependencies: [
        .module(.DLCore),
        .module(.DLNetwork),
    ]
)
