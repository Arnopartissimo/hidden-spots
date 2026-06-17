import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = SpotViewModel()
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            SpotMapView(viewModel: viewModel)
                .tabItem {
                    Label("Map", systemImage: "map")
                }
                .tag(0)
            
            SpotListView(viewModel: viewModel)
                .tabItem {
                    Label("Spots", systemImage: "photo.stack")
                }
                .tag(1)
            
            ProfileView(viewModel: viewModel)
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
                .tag(2)
        }
    }
}

struct SpotListView: View {
    @ObservedObject var viewModel: SpotViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                CityPickerView(viewModel: viewModel)
                CategoryFilterView(viewModel: viewModel)
                
                List(viewModel.filteredSpots) { spot in
                    NavigationLink(destination: SpotDetailView(spot: spot, viewModel: viewModel)) {
                        SpotRowView(spot: spot)
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("Hidden Spots")
        }
    }
}

struct SpotRowView: View {
    let spot: Spot
    
    var body: some View {
        HStack {
            Image(systemName: spot.spotCategory.icon)
                .font(.title2)
                .frame(width: 40, height: 40)
                .background(Color.accentColor.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(spot.name)
                    .font(.headline)
                Text(spot.spotCategory.displayName)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(spot.bestTime)
                    .font(.caption2)
                    .foregroundStyle(.orange)
            }
            
            Spacer()
            
            if spot.isPremium {
                Image(systemName: "crown.fill")
                    .foregroundStyle(.yellow)
            }
        }
        .padding(.vertical, 4)
    }
}

struct CityPickerView: View {
    @ObservedObject var viewModel: SpotViewModel
    
    var body: some View {
        Picker("City", selection: $viewModel.selectedCity) {
            ForEach(viewModel.cities(), id: \.self) { city in
                Text(city).tag(city)
            }
        }
        .pickerStyle(.segmented)
        .padding(.horizontal)
    }
}

struct CategoryFilterView: View {
    @ObservedObject var viewModel: SpotViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                FilterChip(title: "All", isSelected: viewModel.selectedCategory == nil) {
                    viewModel.selectedCategory = nil
                }
                
                ForEach(SpotCategory.allCases) { category in
                    FilterChip(title: category.displayName, isSelected: viewModel.selectedCategory == category) {
                        viewModel.selectedCategory = category
                    }
                }
            }
            .padding(.horizontal)
        }
        .padding(.vertical, 8)
    }
}

struct FilterChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.caption)
                .fontWeight(isSelected ? .bold : .regular)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(isSelected ? Color.accentColor : Color.gray.opacity(0.2))
                .foregroundStyle(isSelected ? .white : .primary)
                .clipShape(Capsule())
        }
    }
}

struct ProfileView: View {
    @ObservedObject var viewModel: SpotViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Hidden Spots")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                VStack(spacing: 8) {
                    Text(viewModel.isPremium ? "Premium Member" : "Free Plan")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    if !viewModel.isPremium {
                        Button("Upgrade to Premium — $4.99/month") {
                            // TODO: RevenueCat purchase
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Profile")
        }
    }
}

#Preview {
    ContentView()
}
