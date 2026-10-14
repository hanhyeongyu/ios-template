import ProjectDescription
import ProjectDescriptionHelpers
import EnvironmentPlugin
import DependencyPlugin

let nameAttribute: Template.Attribute = .required("name")

let template = Template(
    description: "Module template",
    attributes: [
        nameAttribute,
    ],
    items: [
        .file(path: "Projects/{{ name | capitalize }}/Project.swift", templatePath: "module_project.stencil"),
        .file(path: "Projects/{{ name | capitalize }}/Sources/Model/{{ name | capitalize }}.swift", templatePath: "module_model.stencil"),
        .file(path: "Projects/{{ name | capitalize }}/Sources/View/{{ name | capitalize }}View.swift", templatePath: "module_view.stencil"),
        .directory(
            path: "Projects/{{ name | capitalize }}",
            sourcePath: "Resources"
        ),
    ]
)
