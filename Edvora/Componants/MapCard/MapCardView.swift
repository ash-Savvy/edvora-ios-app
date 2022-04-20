//
//  MapCardView.swift
//  Edvora
//
//  Created by TeCh_SavVy on 18/04/22.
//

import SwiftUI
import MapKit

struct MapCardView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    var model: RideModel
    var distance: String
    var body: some View {
        CardView(strokeColor: .clear, paddingVal: 0, backgroundColor: .secondaryBackgrond, cornerRadius: 10) {
            VStack {
                ZStack(alignment: .bottomTrailing) {
                Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: .constant(.follow))
                    .frame(maxWidth: .infinity)
                    .allowsHitTesting(false)
                    PrimaryButton(title: distance, size: .medium, state: .filled).padding(.trailing, 10)
                        .padding(.bottom, 10)
                }
                if let id = model.id {
                    MapViewBottom(rideID: "\(id)", date: DateUtils.formattedDate(model.date ?? "", from: .ddmmmyyyT, to: .ddMMM)).padding(.vertical, 16)
                }
            }
        }
        .background(Color.secondaryBackgrond)
            .cornerRadius(10)
            .padding(.horizontal, 20)
            .frame(height: screenHeight / 3.5)
            
    }
}

struct MapViewBottom: View {
    var rideID: String
    var date: String
    var body: some View {
        HStack {
            ImageLabel(title: rideID, image: "hashTag")
            Spacer()
            ImageLabel(title: date, image: "date_range")
        }.padding(.horizontal, 16)
    }
}

//struct MapCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapCardView()
//    }
//}

struct ImageLabel: View {
    var title: String
    var image: String
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            Image(image).resizable()
                .frame(width: 20, height: 20, alignment: .center)
            Text(title).Inter(.interMedium)
                .foregroundColor(.primaryBlack)
        }
    }
}
