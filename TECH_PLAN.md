# Hidden Spots — Plan Technique MVP

## Architecture globale

```
┌─────────────────────────────────────────┐
│              SwiftUI Views              │
│  ContentView / SpotMapView / SpotDetail │
├─────────────────────────────────────────┤
│            ViewModels (MVVM)            │
│         SpotViewModel (State)           │
├─────────────────────────────────────────┤
│              Services                   │
│   SpotService / RevenueCatService       │
├─────────────────────────────────────────┤
│              Models                     │
│   Spot (SwiftData) + DTO JSON           │
├─────────────────────────────────────────┤
│         Local + Remote Data             │
│   spots.json / SwiftData / Firestore    │
└─────────────────────────────────────────┘
```

## Stack technique MVP

| Couche | Technologie | Raison |
|---|---|---|
| UI | SwiftUI | Rapide, natif, parfait pour cartes/listes |
| Cartes | MapKit | Gratuit, natif, offline possible |
| Stockage local | SwiftData | Persistance, offline, favoris |
| Backend | Firebase (Firestore + Auth + Storage) | Setup rapide pour solo dev |
| Paiements | RevenueCat | Gère les abonnements iOS en 2 lignes |
| Photos | Firebase Storage / Unsplash | Hébergement images |
| Analytics | Firebase Analytics + Mixpanel | Comprendre le funnel |

## Modèle de données

### Spot (SwiftData)

```swift
@Model
class Spot {
    @Attribute(.unique) var id: UUID
    var name: String
    var city: String
    var country: String
    var latitude: Double
    var longitude: Double
    var category: String        // rawValue SpotCategory
    var crowdLevel: Int         // rawValue CrowdLevel
    var accessDifficulty: String// rawValue AccessDifficulty
    var bestTime: String
    var descriptionText: String
    var tips: String
    var examplePhotoURLs: [String]
    var isPremium: Bool
    var createdAt: Date
    var updatedAt: Date
}
```

### Favori / Liste

```swift
@Model
class SavedList {
    @Attribute(.unique) var id: UUID
    var name: String
    var createdAt: Date
    @Relationship var spots: [Spot]
}
```

### Utilisateur (local + cloud)

```swift
struct AppUser {
    var id: String
    var isPremium: Bool
    var premiumExpiry: Date?
    var favoriteSpotIDs: [UUID]
    var downloadedCities: [String]
}
```

## Écrans et navigation

```
ContentView (TabView)
├── Map Tab
│   └── SpotMapView
│       └── SpotDetailView (sheet)
├── Spots Tab
│   └── SpotListView
│       ├── CityPicker
│       ├── CategoryFilter
│       └── SpotDetailView (push)
└── Profile Tab
    └── ProfileView
        └── PaywallView
```

## Flux utilisateur MVP

### 1. First Launch
1. Splash screen avec logo.
2. Onboarding 3 pages : découvrir, filtrer, capturer.
3. Demande de permission localisation (optionnel).
4. Accès gratuit à 3-5 spots par ville.

### 2. Découverte d'un spot
1. Utilisateur ouvre la carte ou la liste.
2. Choisit une ville (Lisbon, Paris, Tokyo...).
3. Filtre par catégorie (sunset, street, rooftop...).
4. Tap sur un spot → fiche détaillée.
5. Si spot premium et user gratuit → paywall.

### 3. Conversion premium
1. User tente d'ouvrir un spot premium.
2. Bottom sheet paywall s'affiche.
3. Proposition : $4.99/mois ou $29.99/an.
4. Paiement via RevenueCat → unlock.

### 4. Offline
1. Premium user télécharge une ville.
2. Toutes les données + photos sont stockées localement.
3. Mode offline fonctionne sans connexion.

## Gestion de l'état

- `SpotViewModel` : état global des spots, filtres, ville sélectionnée, statut premium.
- `@State` dans les vues pour l'UI locale (sheet ouvert/fermé, favori toggle).
- SwiftData pour la persistance locale des favoris et spots téléchargés.
- RevenueCat pour l'état premium synchronisé.

## Paywall strategy

| Feature | Free | Premium |
|---|---|---|
| Spots visibles | 3-5 par ville | Illimités |
| Carte | Oui | Oui |
| Filtres | Basiques | Avancés |
| Favoris | 1 liste | Illimité |
| Offline | Non | Oui |
| Itinéraires | Non | Oui |
| Spots secrets | Non | Oui |

## Offline strategy

1. Stocker les spots en SwiftData.
2. Télécharger les images dans le cache local (FileManager / NSCache).
3. Marquer les villes comme "downloaded" dans le profil utilisateur.
4. En offline : lire depuis SwiftData + cache.

## Roadmap d'implémentation (8 semaines)

### Semaine 1-2 : Fondations
- [ ] Créer le projet Xcode
- [ ] Configurer SwiftData
- [ ] Modèles Spot + enums
- [ ] Chargement JSON local
- [ ] Tests unitaires

### Semaine 3-4 : UI Core
- [ ] Carte MapKit avec markers
- [ ] Liste des spots avec filtres
- [ ] Fiche détaillée spot
- [ ] Favoris avec SwiftData

### Semaine 5 : Paywall
- [ ] Intégrer RevenueCat
- [ ] Configurer abonnements App Store Connect
- [ ] Paywall bottom sheet
- [ ] Gestion du statut premium

### Semaine 6 : Offline
- [ ] Téléchargement ville
- [ ] Cache images
- [ ] Mode offline

### Semaine 7 : Itinéraires
- [ ] Sélection multi-spots
- [ ] Itinéraire optimisé
- [ ] Export PDF (optionnel)

### Semaine 8 : Polish & Beta
- [ ] Onboarding
- [ ] Analytics
- [ ] Beta TestFlight
- [ ] Landing page

## Prochaines étapes immédiates

1. Ouvrir le dossier `hidden-spots` dans Xcode.
2. Créer un nouveau projet SwiftUI et importer les fichiers.
3. Configurer RevenueCat et Firebase.
4. Lancer sur simulateur.
