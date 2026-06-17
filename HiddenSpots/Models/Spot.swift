import Foundation
import MapKit
import SwiftData

enum SpotCategory: String, Codable, CaseIterable, Identifiable {
    case sunrise, sunset, architecture, street, nature, portrait, food, rooftop, neon, skyline
    
    var id: String { rawValue }
    
    var displayName: String {
        switch self {
        case .sunrise: return "Sunrise"
        case .sunset: return "Sunset"
        case .architecture: return "Architecture"
        case .street: return "Street"
        case .nature: return "Nature"
        case .portrait: return "Portrait"
        case .food: return "Food"
        case .rooftop: return "Rooftop"
        case .neon: return "Neon"
        case .skyline: return "Skyline"
        }
    }
    
    var icon: String {
        switch self {
        case .sunrise: return "sunrise"
        case .sunset: return "sunset"
        case .architecture: return "building.columns"
        case .street: return "figure.walk"
        case .nature: return "leaf"
        case .portrait: return "person"
        case .food: return "fork.knife"
        case .rooftop: return "arrow.up.circle"
        case .neon: return "lightbulb"
        case .skyline: return "building.2"
        }
    }
}

enum CrowdLevel: Int, Codable, Identifiable {
    case hidden = 1
    case local = 2
    case popular = 3
    case touristy = 4
    case crowded = 5
    
    var id: Int { rawValue }
    
    var displayName: String {
        switch self {
        case .hidden: return "Hidden gem"
        case .local: return "Local secret"
        case .popular: return "Popular"
        case .touristy: return "Touristy"
        case .crowded: return "Often crowded"
        }
    }
}

enum AccessDifficulty: String, Codable, Identifiable {
    case easy, moderate, hard, restricted
    
    var id: String { rawValue }
    
    var displayName: String {
        switch self {
        case .easy: return "Easy access"
        case .moderate: return "Short walk"
        case .hard: return "Difficult"
        case .restricted: return "Restricted"
        }
    }
}

struct PhotoCredit: Codable {
    let url: String
    let source: String
    let photographer: String
    let photographerUrl: String
}

@Model
class Spot {
    @Attribute(.unique) var id: UUID
    var name: String
    var city: String
    var country: String
    var latitude: Double
    var longitude: Double
    var category: String
    var crowdLevel: Int
    var accessDifficulty: String
    var bestTime: String
    var descriptionText: String
    var tips: String
    var examplePhotoURLs: [String]
    var photoCredits: [PhotoCredit]
    var isPremium: Bool
    
    init(id: UUID = UUID(),
         name: String,
         city: String,
         country: String,
         latitude: Double,
         longitude: Double,
         category: SpotCategory,
         crowdLevel: CrowdLevel,
         accessDifficulty: AccessDifficulty,
         bestTime: String,
         descriptionText: String,
         tips: String,
         examplePhotoURLs: [String],
         photoCredits: [PhotoCredit] = [],
         isPremium: Bool = true) {
        self.id = id
        self.name = name
        self.city = city
        self.country = country
        self.latitude = latitude
        self.longitude = longitude
        self.category = category.rawValue
        self.crowdLevel = crowdLevel.rawValue
        self.accessDifficulty = accessDifficulty.rawValue
        self.bestTime = bestTime
        self.descriptionText = descriptionText
        self.tips = tips
        self.examplePhotoURLs = examplePhotoURLs
        self.photoCredits = photoCredits
        self.isPremium = isPremium
    }
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var spotCategory: SpotCategory {
        SpotCategory(rawValue: category) ?? .street
    }
    
    var spotCrowdLevel: CrowdLevel {
        CrowdLevel(rawValue: crowdLevel) ?? .popular
    }
    
    var spotAccessDifficulty: AccessDifficulty {
        AccessDifficulty(rawValue: accessDifficulty) ?? .easy
    }
}
