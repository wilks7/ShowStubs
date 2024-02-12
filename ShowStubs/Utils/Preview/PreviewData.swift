//
//  PreviewData.swift
//  ShowStubs
//
//  Created by Michael on 6/15/23.
//

import Foundation
import SwiftData
import SetlistFMKit
import DrillURL

class PreviewData {
//    
    static let shared = PreviewData()
    
    static let fmSetlists: [FMSetlist] = {
        let result: FMSetlistsResult = try! SetlistFMClient.decode(data: Sample.PhishSetlistsJSON)
        return result.setlist
    }()
    
    static var fmSetlist: FMSetlist? {
        fmSetlists.first
    }
//
    
    static let phish:Artist = Artist(id: "e01646f2-2a04-450d-8bf2-0d993082e058", name: "Phish")
    
//    static var liveShow: LiveShow {
//        let show = ShowAPI.liveShow(from: fmSetlist!, for: phish)
//        return show
//    }
    
//    static let unitedStates = Country(code: "US", name: "United States")
    
//    static let newYork = City(id: "1234", name: "New York", stateCode: "NY", state: "New York", latitude: 40.7128, longitude: -74.0060)
//    
//    static let msg = Venue(id: "4212", name: "Madison Square Garden")
//    
//    static let tour = Tour(name: "Bakers Dozen Tour")
    
    
    static let artists:[Artist] = [phish]

    static let shows: [LiveShow] = []
    
//    static let testShow = LiveShow(id: UUID().uuidString, name: "Test Show",  date: Date.now)

    
    static func generateData(for context: ModelContext) {
        for artist in artists {
            context.insert(artist)
        }
        for show in shows {
            context.insert(show)
        }
    }
//
}

