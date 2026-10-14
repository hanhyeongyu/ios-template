import ProjectDescription
import EnvironmentPlugin

public let defaultProduct: Product = .staticFramework

extension Target {
    public static func create(
        targetName: String,
        product: Product = defaultProduct,
        infoPlist: InfoPlist? = nil,
        sources: ProjectDescription.SourceFilesList? = nil,
        resources: ProjectDescription.ResourceFileElements? = nil,
        scripts: [TargetScript] = [.SwiftLint],
        dependencies: [TargetDependency],
        settings: Settings? = nil,
        coreDataModels: [ProjectDescription.CoreDataModel] = []
    ) -> Target {
        .target(
            name: targetName,
            destinations: env.destinations,
            product: product,
            bundleId: env.organizationName + "." + targetName,
            deploymentTargets: env.deploymentTargets,
            infoPlist: infoPlist ?? .extendingDefault(with: ["UIDesignRequiresCompatibility": true]),
            sources: sources ?? ["Sources/**"],
            resources: resources ?? ["Resources/**"],
            scripts: scripts,
            dependencies: dependencies,
            settings: settings,
            coreDataModels: coreDataModels
        )
    }

    public static func createWithoutResource(
        targetName: String,
        product: Product = defaultProduct,
        infoPlist: InfoPlist? = nil,
        sources: ProjectDescription.SourceFilesList? = nil,
        scripts: [TargetScript] = [.SwiftLint],
        dependencies: [TargetDependency],
        settings: Settings? = nil,
        coreDataModels: [ProjectDescription.CoreDataModel] = []
    ) -> Target {
        .target(
            name: targetName,
            destinations: env.destinations,
            product: product,
            bundleId: env.organizationName + "." + targetName,
            deploymentTargets: env.deploymentTargets,
            infoPlist: infoPlist ?? .extendingDefault(with: ["UIDesignRequiresCompatibility": true]),
            sources: sources ?? ["Sources/**"],
            resources: [],
            scripts: scripts,
            dependencies: dependencies,
            settings: settings,
            coreDataModels: coreDataModels
        )
    }
}

extension Target {
    /// Runnable app that shows a single module in isolation. Sources live in `Example/Sources`.
    public static func example(
        moduleName: String,
        dependencies: [TargetDependency]
    ) -> Target {
        .target(
            name: moduleName + "Example",
            destinations: env.destinations,
            product: .app,
            bundleId: env.organizationName + "." + moduleName + "Example",
            deploymentTargets: env.deploymentTargets,
            infoPlist: .extendingDefault(with: [
                "CFBundleDisplayName": .string(moduleName + " Example"),
                "CFBundleShortVersionString": "1.0.0",
                "CFBundleVersion": "1",
                "UILaunchScreen": [
                    "UIColorName": "",
                    "UIImageName": ""
                ],
                "UISupportedInterfaceOrientations": ["UIInterfaceOrientationPortrait"],
                "UIDesignRequiresCompatibility": true
            ]),
            sources: ["Example/Sources/**"],
            dependencies: [.target(name: moduleName)] + dependencies
        )
    }
}

extension Scheme {
    public static func example(moduleName: String) -> Scheme {
        .scheme(
            name: moduleName + "Example",
            buildAction: .buildAction(targets: [.target(moduleName + "Example")]),
            runAction: .runAction(executable: .target(moduleName + "Example"))
        )
    }
}
