//
//  MapDetailViewModel.swift
//  Edvora
//
//  Created by TeCh_SavVy on 19/04/22.
//

import Foundation

class MapDetailViewModel: ObservableObject {
   var mapDetail = MapDetailModel(rideID: "001", originStation: 20, date: "16th Feb", distance: "100 Km", state: "Maharashtra", city: "Panvel", stationPath: [20, 39, 40, 42, 54, 63, 72, 88, 98])
    
    func getstationPoints(indices: [Int]) -> String {
        var result = ""
            result =  "\(indices)"
        return result
    }
    
    func getDistance(userStation: Int, model: RideModel) -> String {
        guard let stations = model.station_path else { return "" }
        let closest = stations.enumerated().min( by: { abs($0.1 - userStation) < abs($1.1 - userStation) } )!
        return "\(abs(userStation - closest.element))"
    }
    
    func formatDate(date: String) -> String {
        return DateUtils.formattedDate(date, from: .ddmmmyyyT, to: .ddMMM)
    }
}

struct MapDetailModel: Hashable {
    var rideID: String
    var originStation: Int
    var date: String
    var distance: String
    var state: String
    var city: String
    var stationPath: [Int]
}
