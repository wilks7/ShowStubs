//
//  PreviewData.swift
//  ShowStubs
//
//  Created by Michael on 6/15/23.
//

import Foundation
import SwiftData
import SetlistFMKit

class PreviewData {
//    
    static let shared = PreviewData()
//    
    static let artists:[Artist] = [phish]
    
    static let phish:Artist = Artist(id: "e01646f2-2a04-450d-8bf2-0d993082e058", name: "Phish")
    
    static let shows: [LiveShow] = [testShow]
    
    static let testShow = LiveShow(id: UUID().uuidString, name: "Test Show",  date: Date.now, artistName: "TestArtist")

    
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
extension PreviewData {
    static var PhishFM: FMArtist {
        let json = """
        {
          "mbid": "e01646f2-2a04-450d-8bf2-0d993082e058",
          "name": "Phish",
          "sortName": "Phish",
          "disambiguation": "",
          "url": "https://www.setlist.fm/setlists/phish-13d6ad51.html"
        }
        """.data(using: .utf8)!

        let decoder = JSONDecoder()
        return try! decoder.decode(FMArtist.self, from: json)
    }
}

