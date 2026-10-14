import ProjectDescription

extension TargetDependency {
    public enum Feature {}
}

/// Feature(UI) modules. Add one entry per `make feature name=<Name>`.
public extension TargetDependency.Feature {
    static let Cart: TargetDependency = .project(target: "Cart", path: .relativeToRoot("Projects/Feature/Cart"))
}
