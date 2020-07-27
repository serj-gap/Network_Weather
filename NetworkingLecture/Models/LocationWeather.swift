//
//  LocationWeather.swift
//  NetworkingLecture
//
//  Created by Oleksandr Yehorov1 on 6/25/20.
//  Copyright © 2020 Oleksandr Yehorov1. All rights reserved.
//

import Foundation

struct WeatherForDays: Codable {
    var data: [Weather]
    var sunriseTime: String
    var sunsetTime: String

    enum CodingKeys: String, CodingKey {
        case data = "consolidated_weather"
        case sunriseTime = "sun_rise"
        case sunsetTime = "sun_set"
    }
}

struct Weather: Codable {
    var id: Int
    var stateName: String
    var stateAbbr: String
    var min_temp: Double
    var max_temp: Double
    var the_temp: Double
    var humidity: Int
    var wind_speed: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case stateName = "weather_state_name"
        case stateAbbr = "weather_state_abbr"
        case min_temp
        case max_temp
        case the_temp
        case humidity
        case wind_speed
        
       }
    
    
}
