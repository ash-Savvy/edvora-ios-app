//
//  RidesViewModel.swift
//  Edvora
//
//  Created by TeCh_SavVy on 19/04/22.
//

import Foundation

class RidesViewModel: ObservableObject {
    
    var arrayOfStates: [String] {
        let states = rideModel?.map({$0.state ?? ""}) ?? []
        return states.removingDuplicates()
    }
    
    var arrayOfCities: [String] {
        let cities = rideModel?.filter({$0.state == self.selectedState}).map({$0.city ?? ""}) ?? []
        return cities.removingDuplicates()
    }
    var pastRides: [RideModel]? {
        return getPastRides()
    }
    
    var upCommingRides: [RideModel]? {
        return getFutureRide()
    }
    
    var userStationCode: Int {
        return userModel?.station_code ?? 0
    }
    
    var nearest: [Dictionary<Int, RideModel>.Element] {
        return getNearest()
    }
    
    var nearestRide: [RideModel]? {
        return nearest.map({$0.1})
    }
    var selectedRide: RideModel?
    
    @Published var showDetails = false
    @Published var showFilter = false
    
    @Published var tabs: [TopTab] = [.init(title: "Nearest"),
                                     .init(title: "Upcoming (0)"),
                                 .init(title: "Past (0)")]
    @Published var selectedTab = 0
    @Published var selectedState: String = ""
    @Published var selectedCity: String = ""
    @Published var selectedStateIndex = 0
    @Published var selectedCityIndex = 0

    @Published var rideModel: [RideModel]?
    @Published var userModel: User?
    
    // MARK: - Webservice call
    func getUser() async {
        let baseURL = Constants.baseUrl + Constants.EndPoint.user
        guard let url = URL(string: baseURL) else {
            print("Invalid URL")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(User.self, from: data) {
                DispatchQueue.main.async {
                    self.userModel = decodedResponse.self
                    print(self.arrayOfStates)
                }
            }
            
        } catch {
            print("Invalid data")
        }
    }
    
    func getRides() async {
        let baseURL = Constants.baseUrl + Constants.EndPoint.rides
        guard let url = URL(string: baseURL) else {
            print("Invalid URL")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode([RideModel].self, from: data) {
                DispatchQueue.main.async {
                    self.rideModel = decodedResponse.self
                    print(self.arrayOfStates)
                    self.tabs = [.init(title: "Nearest"),
                                 .init(title: "Upcoming (\(self.getFutureRide()?.count ?? 0))"),
                                 .init(title: "Past (\(self.getPastRides()?.count ?? 0))")]
                    
                }
            }
            
        } catch {
            print("Invalid data")
        }
       
    }
    
    func getNearest() -> [Dictionary<Int, RideModel>.Element] {
        var data: [Int: RideModel] = [:]
        
        rideModel?.forEach({ ride in
            if let numbers = ride.station_path {
                let closest = numbers.enumerated().min( by: { abs($0.1 - userStationCode) < abs($1.1 - userStationCode) } )!
                let nearest = closest.element - userStationCode
                    data[nearest] = ride
            }
        })
        let sortedTwo = data.sorted {
            return $0.0 > $1.0
        }
        return sortedTwo
    }
    
    func getFutureRide() -> [RideModel]? {
        return rideModel?.filter({ DateUtils.extractDate(date: $0.date, from: .ddmmmyyyT) > Date()})
    }
    
    func getPastRides() -> [RideModel]? {
        return rideModel?.filter({ DateUtils.extractDate(date: $0.date, from: .ddmmmyyyT) < Date()})
    }
    
    
    func getDistance(model: RideModel) -> String {
        guard let stations = model.station_path else { return "" }
        let closest = stations.enumerated().min( by: { abs($0.1 - self.userStationCode) < abs($1.1 - self.userStationCode) } )!
        return "\(abs(self.userStationCode - closest.element)) Km"
    }
}

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}

extension Date {
    var isPastDate: Bool {
        return self < Date()
    }
}
