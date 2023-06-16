////
////  Setlist.swift
////  ShowStubs
////
////  Created by Michael on 6/15/23.
////
//
//import Foundation
//import SwiftData
//import SetlistFMKit
//
//@Model
//class Setlist: Identifiable {
//    public let id: String
//    var versionID: String?
//    
//    var date: Date?
//    var sets: [Set]
//    var venue: String?
//    var info: String?
//    var tour: String?
//    
//    init(id: String) {
//        self.sets = []
//        self.id = id
//    }
//    
//    init(from setlist: FMSetlist) {
//
//        self.id = setlist.id
//        self.versionID = setlist.versionId
//        self.venue = setlist.venue?.name
//        self.tour = setlist.tour?.name
//
//        if let sets = setlist.sets?.set {
//            let sets: [Set] = sets.map { set in
//                
//                let songs = set.song.map{ Song(song: $0) }
//                return Set(name: set.name ?? "Set Name", encore: set.encore ?? 0, songs: songs)
//            }
//            self.sets = sets
//        } else {
//            self.sets = []
//        }
//        self.info = setlist.info
//        if let eventDate = setlist.eventDate {
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "dd-MM-yyyy"
//            self.date = dateFormatter.date(from: eventDate)
//        }
//    }
//    
//}
