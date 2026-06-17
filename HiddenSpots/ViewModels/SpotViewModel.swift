import Foundation
import SwiftData
import Combine

@MainActor
class SpotViewModel: ObservableObject {
    @Published var spots: [Spot] = []
    @Published var selectedCity: String = "Lisbon"
    @Published var selectedCategory: SpotCategory?
    @Published var showOnlyFree: Bool = false
    @Published var isPremium: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        loadSpots()
    }
    
    func loadSpots() {
        spots = SpotService.shared.loadSpots()
    }
    
    var filteredSpots: [Spot] {
        spots.filter { spot in
            let cityMatch = spot.city == selectedCity
            let categoryMatch = selectedCategory == nil || spot.spotCategory == selectedCategory
            let freeMatch = !showOnlyFree || !spot.isPremium
            return cityMatch && categoryMatch && freeMatch
        }
    }
    
    var freeSpotsCount: Int {
        spots.filter { $0.city == selectedCity && !$0.isPremium }.count
    }
    
    var premiumSpotsCount: Int {
        spots.filter { $0.city == selectedCity && $0.isPremium }.count
    }
    
    func canViewSpot(_ spot: Spot) -> Bool {
        !spot.isPremium || isPremium
    }
    
    func cities() -> [String] {
        Array(Set(spots.map { $0.city })).sorted()
    }
}
