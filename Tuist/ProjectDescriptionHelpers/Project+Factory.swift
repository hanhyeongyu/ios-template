import ProjectDescription
import EnvironmentPlugin

extension Settings {
    public static let projectSettings: Settings = .settings(
        base: env.baseSetting,
        configurations: [
            .debug(name: "Debug"),
            .release(name: "Release")
        ],
        defaultSettings: .recommended
    )
}

extension Project {
    public static func create(
        name: String,
        packages: [Package],
        settings: Settings? = Settings.projectSettings,
        targets: [Target],
        schemes: [Scheme]
    ) -> Project {
        Project(
            name: name,
            organizationName: env.organizationName,
            options: .options(
                disableBundleAccessors: true,
                disableSynthesizedResourceAccessors: true
            ),
            packages: packages,
            settings: settings,
            targets: targets,
            schemes: schemes
        )
    }

    public static func create(
        name: String,
        packages: [Package],
        settings: Settings? = Settings.projectSettings,
        targets: [Target],
        schemes: [Scheme],
        resourceSynthesizers: [ResourceSynthesizer] = []
    ) -> Project {
        Project(
            name: name,
            organizationName: env.organizationName,
            options: .options(
                defaultKnownRegions: ["en", "ko"],
                developmentRegion: "ko"
            ),
            packages: packages,
            settings: settings,
            targets: targets,
            schemes: schemes,
            resourceSynthesizers: resourceSynthesizers
        )
    }
}
