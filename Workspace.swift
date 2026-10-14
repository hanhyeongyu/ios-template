import ProjectDescription
import EnvironmentPlugin

let workspace = Workspace(
    name: env.name,
    projects: [
        "Projects/App/**",
        "Projects/DesignSystem/**",
        "Projects/Core/**",
        "Projects/Feature/**",
        "Projects/Platform/**"
    ]
)
