import ProjectDescription

extension TargetDependency {
    public enum Platform {}
}

public extension TargetDependency.Platform {
    static let AppUtil: TargetDependency = .project(target: "AppUtil", path: .relativeToRoot("Projects/Platform"))
    static let Event: TargetDependency = .project(target: "Event", path: .relativeToRoot("Projects/Platform"))
    static let LogUtil: TargetDependency = .project(target: "LogUtil", path: .relativeToRoot("Projects/Platform"))
    static let CombineUtil: TargetDependency = .project(target: "CombineUtil", path: .relativeToRoot("Projects/Platform"))
    static let UIUtil: TargetDependency = .project(target: "UIUtil", path: .relativeToRoot("Projects/Platform"))
    static let Preference: TargetDependency = .project(target: "Preference", path: .relativeToRoot("Projects/Platform"))
    static let Networks: TargetDependency = .project(target: "Networks", path: .relativeToRoot("Projects/Platform"))
    static let Auth: TargetDependency = .project(target: "Auth", path: .relativeToRoot("Projects/Platform"))
    static let StorageUtil: TargetDependency = .project(target: "StorageUtil", path: .relativeToRoot("Projects/Platform"))
    static let Notification: TargetDependency = .project(target: "Notification", path: .relativeToRoot("Projects/Platform"))
}
