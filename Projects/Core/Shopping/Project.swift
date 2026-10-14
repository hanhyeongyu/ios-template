import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.create(
    name: "Shopping",
    packages: [],
    settings: Settings.projectSettings,
    targets: [
        .create(
            targetName: "Shopping",
            dependencies: [
                .Platform.AppUtil,
                .Platform.LogUtil
            ]
        ),
        .create(
            targetName: "ShoppingTests",
            product: .unitTests,
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            scripts: [],
            dependencies: [
                .target(name: "Shopping")
            ]
        )
    ],
    schemes: [],
    resourceSynthesizers: .default
)
