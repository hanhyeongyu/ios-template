import ProjectDescription
import ProjectDescriptionHelpers
import EnvironmentPlugin
import DependencyPlugin

let project = Project(
    name: env.name,
    organizationName: env.organizationName,
    options: .options(
        defaultKnownRegions: ["en", "ko"],
        developmentRegion: "ko"
    ),
    settings: Settings.projectSettings,
    targets: [
        .target(
            name: env.name,
            destinations: env.destinations,
            product: .app,
            bundleId: "com" + "." + env.organizationName + "." + env.name,
            deploymentTargets: env.deploymentTargets,
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchStoryboardName": "LaunchScreen",
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": ""
                    ],
                    "UISupportedInterfaceOrientations": [
                        "UIInterfaceOrientationPortrait"
                    ],
                    "NSSupportsLiveActivities": true,
                    "FirebaseAppDelegateProxyEnabled": false,
                    "UIDesignRequiresCompatibility": true
                ]
            ),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            scripts: [.SwiftLint, .GoogleService, .FirebaseCrashlytics],
            dependencies: [
                // Platform
                .Platform.AppUtil,
                .Platform.LogUtil,
                .Platform.CombineUtil,
                .Platform.UIUtil,
                .Platform.Preference,
                .Platform.Networks,
                .Platform.Auth,
                .Platform.StorageUtil,
                .Platform.Notification,

                .DesignSystem,

                // Feature
                .Feature.Cart,

                // SPM
                .SPM.FirebaseAnalytics,
                .SPM.FirebaseCrashlytics,
                .SPM.FirebaseRemoteConfig,
                .SPM.FirebaseMessaging
            ]
        ),
        .target(
            name: env.name + "Tests",
            destinations: env.destinations,
            product: .unitTests,
            bundleId: env.organizationName + "." + (env.name + "Tests"),
            deploymentTargets: env.deploymentTargets,
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [.target(name: env.name)]
        )
    ]
)
