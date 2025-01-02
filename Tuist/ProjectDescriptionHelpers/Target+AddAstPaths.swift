import ProjectDescription

// https://forums.swift.org/t/xcode-14-1-debugger-error-couldnt-realize-type-of-self/61545/2
public extension Target {
    func addAstPaths() -> Self {
        let targets = dependencies.compactMap { dependency in
            if case let .project(target, _, _, _) = dependency {
                return target
            }
            return nil
        }

        guard !targets.isEmpty else { return self }

        var settings = settings ?? .settings(configurations: [])
        let index = settings.firstOrMakeDebugConfiguration()

        var flags = settings.base["OTHER_LDFLAGS"]?.values ?? []
        flags.append(contentsOf: settings.configurations[index].settings["OTHER_LDFLAGS"]?.values ?? [])

        for target in targets {
            flags.append(contentsOf: ["-Xlinker", "-add_ast_path", "-Xlinker", target.astPath])
        }

        settings.configurations[index].settings["OTHER_LDFLAGS"] = .array(flags)

        var target = self
        target.settings = settings
        return target
    }
}

private extension Settings {
    mutating func firstOrMakeDebugConfiguration() -> Int {
        if let index = configurations.firstIndex(where: { $0.name == .debug || $0.variant == .debug }) {
            return index
        }

        configurations.insert(.debug(name: .debug), at: 0)
        return 0
    }
}

private extension SettingValue {
    var values: [String] {
        switch self {
        case let .string(string): [string]
        case let .array(array): array
        @unknown default: []
        }
    }
}

private extension String {
    var astPath: String {
        let paths = [
            "${BUILT_PRODUCTS_DIR}",
            "\(self).swiftmodule",
            "${NATIVE_ARCH}-${LLVM_TARGET_TRIPLE_VENDOR}-${SWIFT_PLATFORM_TARGET_PREFIX}${LLVM_TARGET_TRIPLE_SUFFIX}.swiftmodule"
        ]
        return "'\(paths.joined(separator: "/"))'"
    }
}
