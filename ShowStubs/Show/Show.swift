//
//  Show.swift
//  ShowStubs
//
//  Created by Michael on 6/15/23.
//

import Foundation
import SwiftData
import SetlistFMKit

@Model
class LiveShow: Identifiable {
    public let id: String
    public let date: Date
    public let name: String
    public var artist: Artist?
    public var sets: [Set] = []
    public var venue: String?
    public var tour: String?
    public var info: String?
    public var attended: Bool = false
    
    //    @Relationship
    var artistName: String
    
    
    init(id: String, name: String, date: Date, artistName: String, tour: String? = nil, venue: String? = nil, info: String? = nil) {
        self.id = id
        self.date = date
        self.name = name
        self.venue = venue
        self.tour = tour
        self.info = info
        self.artistName = artistName
    }
}
extension LiveShow {
    
    convenience init?(from setlist: FMSetlist, artist: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        guard let eventDate = setlist.eventDate,
              let date = dateFormatter.date(from: eventDate) else {
            return nil
        }

//        var mappedSets = [Set]()
//        if let sets = setlist.sets?.set {
//            let _sets: [Set] = sets.map { set in
//                let songs = set.song.map{ Song(song: $0) }
//                return Set(name: set.name, encore: set.encore ?? 0, songs: songs)
//            }
//            mappedSets = _sets
//        }
        
        let venue = setlist.venue?.name
        let tour = setlist.tour?.name
        
        self.init(
            id: setlist.id,
            name: venue ?? tour ?? eventDate,
            date: date,
            artistName: artist,
            tour: tour,
            venue: venue,
            info: setlist.info
        )

    }
}
