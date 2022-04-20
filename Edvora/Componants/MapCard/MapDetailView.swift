//
//  MapDetailView.swift
//  Edvora
//
//  Created by TeCh_SavVy on 18/04/22.
//

import SwiftUI
import MapKit

struct MapDetailView: View {
    @EnvironmentObject var viewModel: RidesViewModel
    var body: some View {
        
        VStack {
            VStack(alignment: .leading, spacing: 30) {
                
                MapDetailLatLongView()
                    .padding(.top, 50)
                
                MapDetailCardView(model: viewModel.selectedRide!).environmentObject(viewModel)
                    .shadow(color: .black.opacity(0.5), radius: 15, x: 0, y: 0)
                Spacer()
            }
        
        }.background(BackgroundClearView())
        
    }
}

//
//#if DEBUG
//struct MapDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapDetailView()
//    }
//}
//#endif

struct MapDetailLatLongView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    var body: some View {
        CardView(strokeColor: .clear, paddingVal: 0, backgroundColor: .white, cornerRadius: 17)  {
            Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: .constant(.follow))
                .frame(maxWidth: .infinity)
                .allowsHitTesting(false)
        }
        .cornerRadius(17)
        .padding(.horizontal, 20)
        
    }
}

struct MapDetailCardView: View {
    @StateObject var viewModel = MapDetailViewModel()
    @EnvironmentObject var detailVM: RidesViewModel
    var model: RideModel
    var body: some View {
        
        CardView(strokeColor: .clear, paddingVal: 24, backgroundColor: .white, cornerRadius: 17) {
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    cardLabel(headerLabel: "Ride ID", label: "\(model.id ?? 0)")
                    Spacer()
                    cardLabel(headerLabel: "Origin Station", label: String(model.origin_station_code ?? 0))
                }
                .padding(.vertical, 10)
                Divider()
                HStack {
                    cardLabel(headerLabel: "Date", label: viewModel.formatDate(date: model.date ?? ""))
                    Spacer()
                    cardLabel(headerLabel: "Distance", label: viewModel.getDistance(userStation: detailVM.userStationCode, model: model))
                }.padding(.vertical, 10)
                Divider()
                HStack {
                    cardLabel(headerLabel: "State", label: model.state ?? "")
                    Spacer()
                    cardLabel(headerLabel: "City", label: model.city ?? "")
                }.padding(.vertical, 10)
                Divider()
                cardLabel(headerLabel: "Station Path", label: viewModel.getstationPoints(indices: model.station_path ?? []))
                    .padding(.vertical, 10)
            }
        } .background(Color.white)
            .cornerRadius(17)
            .padding(.horizontal, 20)
        
        
    }
}

struct cardLabel: View {
    var headerLabel: String
    var label: String
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(headerLabel).Inter(.interMedium10)
                .foregroundColor(.primaryGray)
            Text(label).Inter(.interMedium16)
                .foregroundColor(.primaryBlack)
        }
    }
}
