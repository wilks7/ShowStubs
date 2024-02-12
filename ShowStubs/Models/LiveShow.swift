//
//  Show.swift
//  ShowStubs
//
//  Created by Michael on 6/15/23.
//

import SwiftData
import SwiftUI
import MusicAPI

/// A model representing a live show event.
@Model
class LiveShow: Identifiable {
    
    public let id: String
    public let date: Date
    
    public var name: String?
    public var info: String?

    public var artist: Artist!
    
    public var venue: Venue? = nil
    public var tour: Tour? = nil
    
    public var setlist: [Set] = []

    public var attended: Bool = false
    
    public var hexColor: String?

    init(id: String,
         date: Date,
         name: String? = nil,
         info: String? = nil,
         venue: Venue? = nil,
         tour: Tour? = nil
    ) {
        self.id = id
        self.date = date
        self.name = name
        self.info = info
        self.venue = venue
        self.tour = tour
    }
}

extension LiveShow{
    
    @Transient
    public var title: String {
        return name ?? date.formatted(date: .numeric, time: .omitted)
    }
    
    @Transient
    public var color: Color {
        if let hexColor {
            return Color(hex: hexColor)!
//        } else if let tourColor = tour?.hexColor {
//            return Color(hex: tourColor)!
//        } else if let venueColor = venue?.hexColor {
//            return Color(hex: venueColor)!
        } else {
            return Color.indigo
        }
    }
}
//
//extension LiveShow: MusicAPI.Event {
//    public var artistName: String { artist.name }
//}


