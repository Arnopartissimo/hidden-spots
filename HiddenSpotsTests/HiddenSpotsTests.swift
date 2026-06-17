import Testing
import Foundation
@testable import HiddenSpots

struct HiddenSpotsTests {
    
    @Test func spotLoading() async throws {
        let spots = SpotService.shared.loadSpots()
        #expect(spots.count > 0)
        #expect(spots.first?.city == "Lisbon")
    }
    
    @Test func spotCoordinates() async throws {
        let spot = Spot(
            name: "Test Spot",
            city: "Paris",
            country: "France",
            latitude: 48.8566,
            longitude: 2.3522,
            category: .architecture,
            crowdLevel: .popular,
            accessDifficulty: .easy,
            bestTime: "Sunrise",
            descriptionText: "Test",
            tips: "Test",
            examplePhotoURLs: []
        )
        
        #expect(spot.coordinate.latitude == 48.8566)
        #expect(spot.spotCategory == .architecture)
    }
    
    @Test func spotCredits() async throws {
        let spots = SpotService.shared.loadSpots()
        #expect(spots.first?.photoCredits.isEmpty == false)
        #expect(spots.first?.photoCredits.first?.source == "Unsplash")
    }
}
