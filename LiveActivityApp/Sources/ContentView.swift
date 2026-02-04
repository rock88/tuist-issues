import SwiftUI
import Localization
import LiveActivityKit

@available(iOS 16.2, *)
struct ContentView: View {
    @ObservedObject
    var viewModel = ViewModel()

    var body: some View {
        VStack(alignment: .leading) {
            Text("Localization: \(L10n.test)")

            Button("Request LiveActivity", action: viewModel.requestLiveActivity)
            Button("End", action: viewModel.end)
        }
    }
}

@available(iOS 16.2, *)
final class ViewModel: ObservableObject {
    let client: LiveActivityClient = .liveValue

    var activity: LiveActivity?

    func perform(handler: @escaping () async throws -> Void) {
        Task {
            do {
                try await handler()
            } catch {
                print(error)
            }
        }
    }

    func requestLiveActivity() {
        perform {
            let activity = try await self.client.request(.initial())
            print(activity)
            self.activity = activity
        }
    }

    func end() {
        guard let activity else { return }

        perform {
            try await self.client.end(activity, .immediate)
        }
    }
}
