import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    .BannerService,
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
