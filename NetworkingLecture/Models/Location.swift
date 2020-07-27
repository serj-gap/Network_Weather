//
//  Location.swift
//  NetworkingLecture
//
//  Created by Oleksandr Yehorov1 on 6/25/20.
//  Copyright © 2020 Oleksandr Yehorov1. All rights reserved.
//

import Foundation

struct Location: Codable {
    var name: String
    var type: String
    var id: Int
    var coordinates: String
    
    enum CodingKeys: String, CodingKey {
        case name = "title"
        case type = "location_type"
        case id = "woeid"
        case coordinates = "latt_long"
    }
}
//struct LocationArray: Codable {
//    
//}
