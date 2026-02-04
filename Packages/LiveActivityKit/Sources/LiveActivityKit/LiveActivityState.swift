import ActivityKit
import AppIntents

public struct LiveActivityState: Codable, Hashable {
    public static func initial() -> Self {
        Self()
    }
}

public struct LiveActivityAttributes: ActivityAttributes {
    public typealias ContentState = LiveActivityState

    public init() {}
}
