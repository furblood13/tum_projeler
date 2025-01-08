import SwiftUI
import MapKit

struct PharmacyMapView: View {
    let pharmacy: Pharmacy
    @State private var region: MKCoordinateRegion

    init(pharmacy: Pharmacy) {
        self.pharmacy = pharmacy
        let coordinate = Self.getCoordinate(from: pharmacy.loc)
        _region = State(initialValue: MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        ))
    }

    var body: some View {
        Map(coordinateRegion: $region, annotationItems: [pharmacy]) { pharmacy in
            MapMarker(coordinate: Self.getCoordinate(from: pharmacy.loc))
        }
        .navigationTitle(pharmacy.name ?? "Eczane")
        .navigationBarTitleDisplayMode(.inline)
    }
  
    static func getCoordinate(from loc: String?) -> CLLocationCoordinate2D {
        guard let loc = loc else {
            return CLLocationCoordinate2D(latitude: 0, longitude: 0)
        }
        
        let components = loc.split(separator: ",").compactMap { Double($0) }
        guard components.count == 2 else {
            return CLLocationCoordinate2D(latitude: 0, longitude: 0)
        }
        return CLLocationCoordinate2D(latitude: components[0], longitude: components[1])
    }
}


#Preview {
    PharmacyMapView(pharmacy: Pharmacy(name: "Test Eczane", dist: "Test İlçe", address: "Test Adres", phone: "1234567890", loc: "39.92887565500589,32.84444332122803"))
}
