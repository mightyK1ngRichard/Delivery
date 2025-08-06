import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.basic(
    name: "DeliveryApp",
    product: .app,
    bundleSuffix: "App",
    infoPlist: .extendingDefault(with: [
        "UILaunchScreen": [
            "UIColorName": "",
            "UIImageName": "",
        ],
        "CFBundleDisplayName": "${DISPLAY_NAME}",
        "UISupportedInterfaceOrientations": [
            "UIInterfaceOrientationPortrait"
        ],
        "CFBundleShortVersionString": "$(MARKETING_VERSION)",
        "CFBundleVersion": "$(CURRENT_PROJECT_VERSION)",
    ]),
    dependencies: [
        .module(.DLCore),
        .module(.AuthService),
        .module(.BannerService),
        .module(.CartService),
        .module(.CatalogService),
    ]
)
