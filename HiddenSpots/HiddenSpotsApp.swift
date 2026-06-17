import SwiftUI
import SwiftData

@main
struct HiddenSpotsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Spot.self)
    }
}
