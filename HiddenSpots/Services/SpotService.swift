import Foundation

class SpotService {
    static let shared = SpotService()
    
    func loadSpots(from filename: String = "spots") -> [Spot] {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            print("Failed to load spots.json")
            return []
        }
        
        let decoder = JSONDecoder()
        do {
            let spotDTOs = try decoder.decode([SpotDTO].self, from: data)
            return spotDTOs.map { $0.toSpot() }
        } catch {
            print("Failed to decode spots: \(error)")
            return []
        }
    }
}

struct SpotDTO: Codable {
    let id: UUID?
    let name: String
    let city: String
    let country: String
    let latitude: Double
    let longitude: Double
    let category: String
    let crowdLevel: Int
    let accessDifficulty: String
    let bestTime: String
    let descriptionText: String
    let tips: String
    let examplePhotoURLs: [String]
    let isPremium: Bool
    
    func toSpot() -> Spot {
        Spot(
            id: id ?? UUID(),
            name: name,
            city: city,
            country: country,
            latitude: latitude,
            longitude: longitude,
            category: SpotCategory(rawValue: category) ?? .street,
            crowdLevel: CrowdLevel(rawValue: crowdLevel) ?? .popular,
            accessDifficulty: AccessDifficulty(rawValue: accessDifficulty) ?? .easy,
            bestTime: bestTime,
            descriptionText: descriptionText,
            tips: tips,
            examplePhotoURLs: examplePhotoURLs,
            isPremium: isPremium
        )
    }
}
