////
////  Show+Protocol.swift
////  ShowStubs
////
////  Created by Michael on 6/16/23.
////
//
//import SwiftUI
//import SetlistFMKit
//
//protocol ShowProtocol: Identifiable {
//    associatedtype A: ArtistProtocol
//    associatedtype S: SetProtocol
//    var id: String {get}
//    var date: Date {get}
//    var name: String {get}
//    var venueName: String? {get}
//    var tourName: String? {get}
//    var artist_: A {get}
//    var setlist: [S] {get}
//}
//
//protocol LocationProtocol: Identifiable {
//    var id: String {get}
//    var name: String {get}
//}
//
//
//protocol LiveShowView: View {
//    associatedtype Show: ShowProtocol
//    init(show: Show)
//}
//extension LiveShow: ShowProtocol {
//    var artist_: Artist {
//        self.artist
//    }
//
//    var venueName: String? {
//        venue
//    }
//    
//    var tourName: String? {
//        tour
//    }
//    
//    
//}
//
//extension FMSetlist: ShowProtocol {
//    var artist_: FMArtist { self.artist }
//    var setlist: [FMSet] { self.sets?.set ?? [] }
//    
//    var date: Date {
//        eventDate
//    }
//    
//    var name: String {
//        venueName ?? tourName ??
//        eventDate.formatted(date: .abbreviated, time: .omitted)
//    }
//    
//    var venueName: String? {
//        self.venue?.name
//    }
//    
//    var tourName: String? {
//        self.tour?.name
//    }
//    
//    
//}
