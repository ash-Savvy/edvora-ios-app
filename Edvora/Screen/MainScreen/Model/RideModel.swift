//
//  RideModel.swift
//  Edvora
//
//  Created by TeCh_SavVy on 19/04/22.
//

import Foundation


struct RideModel : Codable, Hashable {
    let id : Int?
    let origin_station_code : Int?
    let station_path : [Int]?
    let destination_station_code : Int?
    let date : String?
    let map_url : String?
    let state : String?
    let city : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case origin_station_code = "origin_station_code"
        case station_path = "station_path"
        case destination_station_code = "destination_station_code"
        case date = "date"
        case map_url = "map_url"
        case state = "state"
        case city = "city"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        origin_station_code = try values.decodeIfPresent(Int.self, forKey: .origin_station_code)
        station_path = try values.decodeIfPresent([Int].self, forKey: .station_path)
        destination_station_code = try values.decodeIfPresent(Int.self, forKey: .destination_station_code)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        map_url = try values.decodeIfPresent(String.self, forKey: .map_url)
        state = try values.decodeIfPresent(String.self, forKey: .state)
        city = try values.decodeIfPresent(String.self, forKey: .city)
    }

}

struct User : Codable, Hashable {
    let station_code : Int?
    let name : String?
    let url : String?

    enum CodingKeys: String, CodingKey {

        case station_code = "station_code"
        case name = "name"
        case url = "url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        station_code = try values.decodeIfPresent(Int.self, forKey: .station_code)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }

}
