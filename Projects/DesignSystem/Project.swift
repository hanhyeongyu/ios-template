import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.create(
    name: "DesignSystem",
    packages: [],
    settings: Settings.projectSettings,
    targets: [
        .create(
            targetName: "DesignSystem",
            dependencies: [
                .Platform.UIUtil
            ]
        ),
        .example(moduleName: "DesignSystem", dependencies: [])
    ],
    schemes: [.example(moduleName: "DesignSystem")],
    resourceSynthesizers: [
        .strings(),
        .assets(),
        .fonts()
    ]
)
