//
//  Item.swift
//  ShowStubs
//
//  Created by Michael on 6/14/23.
//

import Foundation
import SwiftData
import SetlistFMKit

@Model
final class Artist {
    public let id: String
    public let name: String
    public let sortName: String?
    public let type: String?
    public let disambiguation: String?
    public let gender: String?
    public let country: String?
    public let aliases: [String] = []
    
    @Relationship(inverse: \LiveShow.artist)
    public var shows: [LiveShow]


    init(id: String, name: String){
        self.id = id
        self.name = name
    }


    init(artist: MBArtist) {
        self.id = artist.id
        self.name = artist.name
        self.sortName = artist.sortName
        self.type = artist.type
        self.disambiguation = artist.disambiguation
        self.gender = artist.gender
        self.country = artist.country
        self.aliases = []
    }
    
}

extension FMArtist: Identifiable, Hashable {
    public var id: String { mbid }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.mbid)
    }
}
