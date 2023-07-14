//
//  WeatherInfo.swift
//  Smart Farmer
//
//  Created by ahmed sherif on 08/06/2023.
//

import Foundation

struct WeatherInfo: Codable {
    let main: Main
    //let temperature: Double
}


struct Main: Codable {
    let temp: Double
}
