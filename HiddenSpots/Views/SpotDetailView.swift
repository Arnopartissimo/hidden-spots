import SwiftUI

struct SpotDetailView: View {
    let spot: Spot
    @ObservedObject var viewModel: SpotViewModel
    @State private var isFavorited = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Header image placeholder
                ZStack {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                    Image(systemName: "photo")
                        .font(.largeTitle)
                        .foregroundStyle(.gray)
                }
                .frame(height: 240)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                
                // Title & premium badge
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(spot.name)
                            .font(.title)
                            .fontWeight(.bold)
                        Text("\(spot.city), \(spot.country)")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                    if spot.isPremium {
                        PremiumBadgeView()
                    }
                }
                
                // Key info chips
                HStack(spacing: 12) {
                    InfoChip(icon: spot.spotCategory.icon, text: spot.spotCategory.displayName)
                    InfoChip(icon: "clock", text: spot.bestTime)
                    InfoChip(icon: "person.3", text: spot.spotCrowdLevel.displayName)
                }
                
                // Description
                Text("About")
                    .font(.headline)
                Text(spot.descriptionText)
                    .font(.body)
                    .foregroundStyle(.secondary)
                
                // Tips
                Text("Photographer Tips")
                    .font(.headline)
                Text(spot.tips)
                    .font(.body)
                    .foregroundStyle(.secondary)
                
                // Access info
                HStack {
                    Image(systemName: "figure.walk")
                    Text(spot.spotAccessDifficulty.displayName)
                    Spacer()
                    Text("Lat: \(String(format: "%.4f", spot.latitude)), Lon: \(String(format: "%.4f", spot.longitude))")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .padding(.vertical, 8)
                
                // Paywall for premium spots
                if !viewModel.canViewSpot(spot) {
                    PremiumPaywallView()
                }
                
                Spacer()
            }
            .padding()
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    isFavorited.toggle()
                } label: {
                    Image(systemName: isFavorited ? "heart.fill" : "heart")
                        .foregroundStyle(isFavorited ? .red : .primary)
                }
            }
        }
    }
}

struct InfoChip: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
                .font(.caption)
            Text(text)
                .font(.caption)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(Color.gray.opacity(0.15))
        .clipShape(Capsule())
    }
}

struct PremiumBadgeView: View {
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "crown.fill")
            Text("Premium")
        }
        .font(.caption)
        .fontWeight(.semibold)
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(Color.orange.opacity(0.15))
        .foregroundStyle(.orange)
        .clipShape(Capsule())
    }
}

struct PremiumPaywallView: View {
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "lock.fill")
                .font(.title2)
                .foregroundStyle(.orange)
            Text("Unlock this spot")
                .font(.headline)
            Text("Upgrade to Premium to access all hidden spots, offline mode, and itineraries.")
                .font(.caption)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
            Button("Upgrade — $4.99/month") {
                // TODO: RevenueCat purchase
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.orange.opacity(0.05))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    SpotDetailView(
        spot: Spot(
            name: "Miradouro da Senhora do Monte",
            city: "Lisbon",
            country: "Portugal",
            latitude: 38.7196,
            longitude: -9.1311,
            category: .sunset,
            crowdLevel: .local,
            accessDifficulty: .easy,
            bestTime: "Sunset",
            descriptionText: "Best panoramic view of Lisbon with the castle and the river. Less crowded than other miradouros.",
            tips: "Arrive 30 min before sunset. Use a 24-70mm lens. The light on the castle is best in summer.",
            examplePhotoURLs: [],
            isPremium: true
        ),
        viewModel: SpotViewModel()
    )
}
