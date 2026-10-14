import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let AppUtil: Target = .createWithoutResource(
    targetName: "AppUtil",
    sources: "Sources/AppUtil/**",
    dependencies: []
)

let Event: Target = .createWithoutResource(
    targetName: "Event",
    sources: "Sources/Event/**",
    dependencies: []
)

let LogUtil: Target = .createWithoutResource(
    targetName: "LogUtil",
    sources: "Sources/LogUtil/**",
    dependencies: [
        .SPM.CocoaLumberjack,
        .SPM.CocoaLumberjackSwift,
        .SPM.FirebaseAnalytics,
        .SPM.FirebaseCrashlytics
    ]
)

let CombineUtil: Target = .createWithoutResource(
    targetName: "CombineUtil",
    sources: "Sources/CombineUtil/**",
    dependencies: [
        .SPM.CombineExt
    ]
)

let UIUtil: Target = .createWithoutResource(
    targetName: "UIUtil",
    sources: "Sources/UIUtil/**",
    dependencies: [
        .SPM.Kingfisher
    ]
)

let Preference: Target = .createWithoutResource(
    targetName: "Preference",
    sources: "Sources/Preference/**",
    dependencies: [
        .SPM.CocoaLumberjack,
        .SPM.CocoaLumberjackSwift
    ]
)

let Networks: Target = .createWithoutResource(
    targetName: "Networks",
    sources: "Sources/Networks/**",
    dependencies: [
        .Platform.AppUtil,
        .Platform.Preference,
        .SPM.Alamofire,
        .SPM.CocoaLumberjack,
        .SPM.CocoaLumberjackSwift
    ]
)

let Auth: Target = .createWithoutResource(
    targetName: "Auth",
    sources: "Sources/Auth/**",
    dependencies: [
        .Platform.Event,
        .Platform.AppUtil,
        .Platform.Preference,
        .Platform.Networks,
        .SPM.Alamofire,
        .SPM.CocoaLumberjack,
        .SPM.CocoaLumberjackSwift
    ]
)

let StorageUtil: Target = .createWithoutResource(
    targetName: "StorageUtil",
    sources: "Sources/StorageUtil/**",
    dependencies: [],
    coreDataModels: [
        .coreDataModel("CoreData/AppDatabase.xcdatamodeld")
    ]
)

let Notification: Target = .createWithoutResource(
    targetName: "Notification",
    sources: "Sources/Notification/**",
    dependencies: []
)

let project = Project.create(
    name: "Platform",
    packages: [],
    targets: [
        AppUtil,
        Event,
        LogUtil,
        CombineUtil,
        UIUtil,
        Preference,
        Networks,
        Auth,
        StorageUtil,
        Notification
    ],
    schemes: []
)
