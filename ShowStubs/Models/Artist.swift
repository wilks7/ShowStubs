//
//  Item.swift
//  ShowStubs
//
//  Created by Michael on 6/14/23.
//

import Foundation
import SwiftData
import SwiftUI
import MusicAPI


@Model
final class Artist: Identifiable, MusicAPI.Artist {
    
    @Attribute(.unique) public let id: String
    public let name: String
    public var sortName: String? = nil

    public var type: String? = nil
    public var disambiguation: String? = nil
    public var country: String? = nil

    public var formed: Date? = nil
    public var ended: Date? = nil
    
    public var image: String? = nil
    public var hexColor: String = Color.indigo.toHex()!
    public var symbol: String = "circle"
    
    
    @Relationship(inverse: \LiveShow.artist)
    public var shows: [LiveShow] = []
    
    
    init(id: String, name: String){
        self.id = id
        self.name = name
    }
    
    init(artist: any MusicAPI.Artist) {
        self.id = artist.id
        self.name = artist.name
    }
    
    
    @Transient
    public var setlists: [FMSetlist] = []
    
    func fetch(){
        Task{@MainActor in
            do {
                self.setlists = try await ProxyService.shared.fetchSetlists(for: self.id)
            } catch {
                print(error)
            }
        }
    }

}

extension Artist {
    @Transient
    public var color: Color {
        Color(hex: hexColor)!
    }

}

import MusicBrainzKit
import SetlistFMKit
extension Artist {
    convenience init(mbArtist: MBArtist) {
        self.init(id: mbArtist.id, name: mbArtist.name)
        self.disambiguation = mbArtist.disambiguation
        self.country = mbArtist.country
//        self.formed = mbArtist.lifeSpan?.begin
//        self.ended = mbArtist.lifeSpan?.end
    }
    
    convenience init(fmArtist: FMArtist) {
        self.init(id: fmArtist.mbid, name: fmArtist.name)
        self.image = fmArtist.url
    }
}
