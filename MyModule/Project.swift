import Foundation
import ProjectDescription

let project = Project(
    name: "MyModule",
    options: .options(automaticSchemesOptions: .disabled),
    targets: [
        .target(
            name: "MyModule",
            destinations: [.iPhone],
            product: .staticLibrary,
            bundleId: "com.test.MyModule",
            deploymentTargets: .iOS("15.0"),
            sources: ["Sources/**"]
        )
    ],
    resourceSynthesizers: []
)
