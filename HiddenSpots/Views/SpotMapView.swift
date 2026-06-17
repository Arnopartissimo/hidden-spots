import SwiftUI
import MapKit

struct SpotMapView: View {
    @ObservedObject var viewModel: SpotViewModel
    @State private var cameraPosition: MapCameraPosition = .region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 38.7223, longitude: -9.1393),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    ))
    @State private var selectedSpot: Spot?
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                Map(position: $cameraPosition, selection: $selectedSpot) {
                    ForEach(viewModel.filteredSpots) { spot in
                        Marker(spot.name, systemImage: spot.spotCategory.icon, coordinate: spot.coordinate)
                            .tint(spot.isPremium ? .orange : .blue)
                            .tag(spot)
                    }
                }
                .mapStyle(.standard)
                
                VStack {
                    CityPickerView(viewModel: viewModel)
                        .padding(.top, 8)
                    Spacer()
                }
            }
            .navigationTitle("Map")
            .sheet(item: $selectedSpot) { spot in
                SpotDetailView(spot: spot, viewModel: viewModel)
                    .presentationDetents([.medium, .large])
            }
            .onChange(of: viewModel.selectedCity) { _, newCity in
                if let firstSpot = viewModel.spots.first(where: { $0.city == newCity }) {
                    withAnimation {
                        cameraPosition = .region(MKCoordinateRegion(
                            center: firstSpot.coordinate,
                            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                        ))
                    }
                }
            }
        }
    }
}

#Preview {
    SpotMapView(viewModel: SpotViewModel())
}
