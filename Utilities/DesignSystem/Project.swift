import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    .DesignSystem,
    packages: [
        .remote(url: "https://github.com/onevcat/Kingfisher.git", requirement: .exact("7.12.0"))
    ],
    additionalTargets: [],
    resources: .resources(["Resources/**"]),
    dependencies: [
        .module(.DLCore),
        .package(product: "Kingfisher")
    ]
)
