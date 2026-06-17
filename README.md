# Hidden Spots

> Find the best photo spots and hidden gems in every city.

## Description

Hidden Spots is an iOS app that helps travelers and photographers discover curated photo spots, plan shoots, and capture the best light.

## MVP Features

- Interactive map of curated photo spots
- Detailed spot cards with best time, crowd level, access info, and example photos
- Advanced filters (category, time of day, budget, crowd level)
- Offline mode for downloaded cities
- Favorites and custom lists
- Optimized itineraries between selected spots
- Freemium paywall: 3-5 free spots per city, premium unlocks all

## Tech Stack

- SwiftUI
- MapKit
- SwiftData / Core Data
- RevenueCat (subscriptions)
- Firebase or Supabase (backend)

## Project Structure

```
HiddenSpots/
├── HiddenSpotsApp.swift
├── Models/
│   └── Spot.swift
├── Services/
│   └── SpotService.swift
├── ViewModels/
│   └── SpotViewModel.swift
├── Views/
│   ├── ContentView.swift
│   ├── SpotMapView.swift
│   └── SpotDetailView.swift
├── Resources/
│   └── spots.json
└── HiddenSpotsTests/
    └── HiddenSpotsTests.swift
```

## Design & Planning Docs

- `DESIGN_GUIDE.md` — Direction visuelle, design system, UX et micro-interactions
- `GAMIFICATION_DESIGN.md` — Système de gamification : points, badges, niveaux, challenges
- `TECH_PLAN.md` — Architecture technique et stack MVP
- `CURATION_BRIEF.md` — Processus de curation des spots photo

## Getting Started

1. Open `HiddenSpots` folder in Xcode.
2. Select an iOS simulator or device.
3. Build and run.

## License

Proprietary — All rights reserved.
