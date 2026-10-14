import ProjectDescription

extension TargetDependency {
    public enum Core {}
}

/// Domain modules. Add one entry per `make core name=<Name>`.
public extension TargetDependency.Core {
    static let Shopping: TargetDependency = .project(target: "Shopping", path: .relativeToRoot("Projects/Core/Shopping"))
}
