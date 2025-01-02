import ProjectDescription

let workspace = Workspace(
    name: "MyApp",
    projects: [
        "MyApp"
    ],
    schemes: [
        .scheme(
            name: "MyApp",
            shared: true,
            buildAction: .buildAction(
                targets: [.project(path: "MyApp", target: "MyApp")]
            ),
            runAction: .runAction(
                executable: .project(path: "MyApp", target: "MyApp")
            )
        )
    ]
)
