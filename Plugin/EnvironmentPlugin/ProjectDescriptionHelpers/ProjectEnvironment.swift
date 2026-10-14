import Foundation
import ProjectDescription


public struct ProjectEnvironment: Sendable {
    public let name: String
    public let organizationName: String
    public let destinations: Destinations
    public let deploymentTargets: DeploymentTargets
    public let baseSetting: SettingsDictionary
}

/// Signing team, supplied by `TUIST_DEVELOPMENT_TEAM` (mise env) so it never lives in the repository.
private let developmentTeamSetting: SettingsDictionary = {
    let team = Environment.developmentTeam.getString(default: "")
    return team.isEmpty ? [:] : ["DEVELOPMENT_TEAM": SettingValue(stringLiteral: team)]
}()

public let env = ProjectEnvironment(
    name: "template",
    organizationName: "company",
    destinations: [.iPhone, .iPad],
    deploymentTargets: .iOS("17.0"),
    baseSetting: developmentTeamSetting.merging([
        "ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES": "NO",
        "ENABLE_USER_SCRIPT_SANDBOXING": "NO"
    ]) { current, _ in current }
)
