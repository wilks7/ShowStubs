//
//  Set.swift
//  ShowStubs
//
//  Created by Michael on 6/15/23.
//

import SwiftData
import SetlistFMKit
import MusicBrainzKit
import Sel

@Model
class Set {
    let name: String?
    let encore: Int?
    var songs: [Song]
    
    init(name: String?, encore: Int?, songs: [Song]) {
        self.name = name
        self.encore = encore
        self.songs = songs
    }
}
extension Set: MusicAPI.Setlist {
    
}


@Model
class Song: Identifiable {
    let name: String?
    var feature: String
    var coverArtist: String
    
    let info: String?
    var tape: Bool = false
    init(name: String?, feature: String? = nil, coverArtist: String? = nil, info: String? = nil, tape: Bool = false) {
        self.name = name
        self.feature = feature ?? ""
        self.coverArtist = coverArtist ?? ""
        self.info = info ?? ""
        self.tape = tape
    }
    
    init(song: FMSong) {
        self.name = song.name
        self.feature = song.with?.name ?? ""
        self.coverArtist = song.cover?.name ?? ""
        self.info = song.info ?? ""
        self.tape = song.tape ?? false
    }
}
extension Song: MusicAPI.Song {
    
}
