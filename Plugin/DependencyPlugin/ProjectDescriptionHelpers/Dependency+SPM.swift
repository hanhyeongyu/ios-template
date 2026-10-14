import ProjectDescription


public extension TargetDependency {
    enum SPM {}
}

public extension TargetDependency.SPM {
    static let Alamofire: TargetDependency = .external(name: "Alamofire")
    static let Kingfisher: TargetDependency = .external(name: "Kingfisher")

    static let CocoaLumberjack: TargetDependency = .external(name: "CocoaLumberjack")
    static let CocoaLumberjackSwift: TargetDependency = .external(name: "CocoaLumberjackSwift")

    static let Lottie: TargetDependency = .external(name: "Lottie")
    static let Collection: TargetDependency = .external(name: "Collections")
    static let CombineExt: TargetDependency = .external(name: "CombineExt")

    static let FirebaseAnalytics: TargetDependency = .external(name: "FirebaseAnalytics")
    static let FirebaseCrashlytics: TargetDependency = .external(name: "FirebaseCrashlytics")
    static let FirebaseRemoteConfig: TargetDependency = .external(name: "FirebaseRemoteConfig")
    static let FirebaseMessaging: TargetDependency = .external(name: "FirebaseMessaging")
}
