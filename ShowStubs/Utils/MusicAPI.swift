//
//  MusicAPI.swift
//  ShowStubs
//
//  Created by Michael Wilkowski on 6/20/23.
//

import Foundation
import MusicAPI
import MusicBrainzKit
import SetlistFMKit
import SwiftData

class ShowAPI {
    
    static private func fetch<O:PersistentModel>(for id: String?) -> O? where O:Identifiable, O.ID == String {
        guard let id else {return nil}
        let container = ShowData.container
        let context = ModelContext(container)
        var descriptor = FetchDescriptor<O>(predicate: #Predicate{$0.id == id} )
        descriptor.fetchLimit = 1
        return try? context.fetch(descriptor).first
    }
    
    static func artist(from mbArtist: MBArtist) -> Artist {
        if let artist: Artist = fetch(for: mbArtist.id) {
            return artist
        } else {
            let artist = Artist(id: mbArtist.id, name: mbArtist.name)
            artist.sortName = mbArtist.sortName
            artist.type = mbArtist.type

            artist.disambiguation = mbArtist.disambiguation
            artist.country = mbArtist.country
            return artist
        }
    }
    
    
    static func artist(from fmArtist: FMArtist) -> Artist {
        if let artist: Artist = fetch(for: fmArtist.mbid) {
            return artist
        } else {
            let artist = Artist(id: fmArtist.mbid, name: fmArtist.name)
            artist.sortName = fmArtist.sortName
            artist.disambiguation = fmArtist.disambiguation
            return artist
        }
    }
    
//    static func city(from city: FMCity) -> City? {
//        let country = Country(code: city.country.code, name: city.country.name)
//
//        let id = city.id
////        if let city: City = fetch(for: id)  {
////            return city
////        } else {
//            guard let id = city.id else {return nil}
//        return City(id: id, name: city.name, stateCode: city.stateCode, state: city.state, country: <#Country#>, latitude: city.latitude, longitude: city.longitude)
////        }
//    }
    
//    static func venue(from venue: FMVenue?) -> Venue? {
//        guard let venue else {return nil}
////        if let venue: Venue = fetch(for: venue.id)  {
////            return venue
////        } else {
//            return Venue(id: venue.id, name: venue.name)
////        }
//    }
//    
//    static func tour(from tour: FMTour?, for artist: Artist) -> Tour? {
//        guard let tour else {return nil }
//        if let tour: Tour = fetch(for: tour.name + "_" + artist.id)  {
//            return tour
//        } else {
//            let tour = Tour(name: tour.name, artistID: artist.id)
//            tour.artist = artist
//            return tour
//        }
//    }
//    
    static func sets(from sets: FMSets?) -> [Set] {
        if let sets {
            let setlist:[Set] = sets.set.map{ set in
                let songs: [Song] = set.song.map{ Song(song: $0) }
                return Set(name: set.name, encore: set.encore ?? 0, songs: songs)
            }
            return setlist
        } else {
            return []
        }
    }
    
    
    static func liveShow(from fmSetlist: FMSetlist, for artist: Artist) -> LiveShow {
//        let tour = tour(from: fmSetlist.tour, for: artist)
//        let venue = venue(from: fmSetlist.venue)
        let setlist = sets(from: fmSetlist.sets)
        
        var venue: Venue?
        if let fmVenue = fmSetlist.venue {
            let fmCity = fmVenue.city
            let country = Country(code: fmCity.country.code, name: fmCity.country.name)
            let city = City(id: fmCity.id ?? fmCity.country.code + "_" + fmCity.name,
                            name: fmCity.name,
                            stateCode: fmCity.stateCode,
                            state: fmCity.state,
                            country: country,
                            latitude: fmCity.latitude,
                            longitude: fmCity.longitude
            )
            
            venue = Venue(id: fmVenue.id, name: fmVenue.name, city: city)
        }
        
        var tour: Tour?
        if let fmTour = fmSetlist.tour {
            tour = Tour(id: artist.id + "_" + fmTour.name, name: fmTour.name)
        }
        
        let show = LiveShow(id: fmSetlist.id, date: fmSetlist.eventDate, name: fmSetlist.title, info: fmSetlist.info, venue: venue, tour: tour)
        show.artist = artist
//        show.tour = tour
//        show.venue = venue
        show.setlist = setlist

        return show
    }
}

public extension MusicBrainzClient {
    static var shared: MusicBrainzClient {
        MusicBrainzClient(appName: "ShowStubs", version: "0.1", orginization: "rifigy")
    }
}

public extension SetlistFMClient {
    static var shared: SetlistFMClient {
        SetlistFMClient(apiKey: "YAuLpSRz4LjQmUgE7lst6ZTkS028LwOelLS9", appName: "ShowStubs", orginization: "rifigy")
    }
}

extension LiveShow {
    
}
