import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.create(
    name: "Cart",
    packages: [],
    settings: Settings.projectSettings,
    targets: [
        .create(
            targetName: "Cart",
            dependencies: [
                .Platform.AppUtil,
                .Platform.LogUtil,
                .DesignSystem,
                .Core.Shopping
            ]
        ),
        .create(
            targetName: "CartTests",
            product: .unitTests,
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            scripts: [],
            dependencies: [
                .target(name: "Cart")
            ]
        ),
        .example(moduleName: "Cart", dependencies: [])
    ],
    schemes: [.example(moduleName: "Cart")],
    resourceSynthesizers: .default
)
