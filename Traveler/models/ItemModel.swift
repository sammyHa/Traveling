//
//  ItemModel.swift
//  Traveler
//
//  Created by Samim Hakimi on 4/11/22.
//

import Foundation

enum Gender {
    case Male, Female
}

struct ItemModel: Identifiable, Codable {
    var id: String
    var name: String
    var quantity: Int
    var isComplete: Bool
}

struct CGDModel: Identifiable {
    var id: String
    var cityName: String
    var gender: Gender
    var days: String
}

struct Weather: Codable {
    var temp: Double?

}

struct WeatherMain: Codable {
    var main: Weather
}


struct WhereTo: Identifiable {
    var id: String
    var city: String
    var temp: String
    var days: String
}
