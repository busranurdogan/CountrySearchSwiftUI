
import SwiftUI
import MapKit

struct IdentifiableCoordinate: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

struct DetailsContentView: View {
    let country: Country
    var routeData : Country.CapitalInfo?
    
    @State private var routeCoordinates: [IdentifiableCoordinate] = []
    @State private var region = MKCoordinateRegion()
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: country.flags.png))
            Text(country.name.official)
                .bold()
            Text(country.capital.first ?? "No Capital")
            Text("\(country.population)")
                
            
        if !routeCoordinates.isEmpty {
                Map(coordinateRegion: $region, annotationItems: routeCoordinates) { item in
                    MapMarker(coordinate: item.coordinate)
                }
                .frame(height: 300)
            }
        }.padding()
        .onAppear {
            if let lat = routeData?.latlng?[0], let lng = routeData?.latlng?[1] {
                let loc = CLLocationCoordinate2D(latitude: lat, longitude: lng)
                routeCoordinates.append(IdentifiableCoordinate(coordinate: loc))
                region = MKCoordinateRegion(center: loc, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
            }
        }
}
}
/*#Preview {
    DetailsContentView(country: country)
}
*/
