import ProjectDescription
import ProjectDescriptionHelpers
import EnvironmentPlugin
import DependencyPlugin

let nameAttribute: Template.Attribute = .required("name")

let template = Template(
    description: "Custom platform template",
    attributes: [
        nameAttribute,
    ],
    items: [
        .file(path: "Projects/Platform/{{ name | capitalize }}/Project.swift", templatePath: "platform_project.stencil"),
        .file(path: "Projects/Platform/{{ name | capitalize }}/Sources/{{ name | capitalize }}.swift", templatePath: "platform_empty_file.stencil")
    ]
)
