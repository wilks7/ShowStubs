//
//  Venue.swift
//  ShowStubs
//
//  Created by Michael Wilkowski on 6/21/23.
//

import SwiftData
import SwiftUI
import MusicAPI

struct Venue: Identifiable, Codable {
    public let id: String
    public let name: String
    public let city: City
    public var hexColor: String = Color.orange.toHex()!

}

struct City: Identifiable, Codable {
    public let id: String
    public let name: String
    public var stateCode: String?
    public var state: String?
    public let country: Country
    public var latitude: Double?
    public var longitude: Double?
}

struct Country: Identifiable, Codable {
    /// The country's [ISO code](http://www.iso.org/iso/english_country_names_and_code_elements). E.g. "ie" for Ireland
    public let code: String
    public let name: String
    public var id: String { code }
}

struct Tour: Identifiable, Codable {
    public let id: String
    public let name: String
    public var hexColor: String = Color.cyan.toHex()!
}

extension Venue: MusicAPI.Venue {

    
    
}
extension City: MusicAPI.City {
    
    var countryName: String {
        country.name
    }
    
    
}


extension Tour: MusicAPI.Tour {}
