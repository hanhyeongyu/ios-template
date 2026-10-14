import ProjectDescription

public extension TargetDependency {
    static let DesignSystem: TargetDependency = .project(
        target: "DesignSystem",
        path: .relativeToRoot("Projects/DesignSystem")
    )
}
