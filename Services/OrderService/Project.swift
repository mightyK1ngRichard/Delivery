import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    .OrderService,
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
