import Foundation
import ProjectDescription

let project = Project(
    name: "MyApp",
    options: .options(automaticSchemesOptions: .disabled),
    targets: [
        .target(
            name: "MyApp",
            destinations: [.iPhone],
            product: .app,
            bundleId: "com.test.MyApp",
            deploymentTargets: .iOS("15.0"),
            infoPlist: .extendingDefault(with: [
                "UILaunchStoryboardName": "LaunchScreen"
            ]),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                .project(target: "MyModule", path: .relativeToRoot("MyModule"))
            ]
        )
    ],
    resourceSynthesizers: []
)
