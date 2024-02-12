//
//  ShowData.swift
//  ShowStubs
//
//  Created by Michael on 6/15/23.
//

import Foundation
import SwiftData


class ShowData {

    static let schema = Schema([
        LiveShow.self,
        Song.self,
        Set.self,
        Artist.self,
    ])
    
    static let container = try! ModelContainer(
        for: schema,
        configurations: [ ModelConfiguration(inMemory: false) ]
    )
}

//
//func fetchAllSetlists(mbid: String) async throws -> [FMSetlist] {
//    var allSetlists = [FMSetlist]()
//    let first = try await getArtistSetlists(mbid: mbid)
//    allSetlists.append(contentsOf: first.setlist)
//
//    print(allSetlists.count, first.total)
//
//    let totalPages = Int(ceil(Double(first.total) / Double(first.itemsPerPage)))
//
//    for page in 2...totalPages {
//        let result = try await getArtistSetlists(mbid: mbid, pageNumber: page)
//        print("Got \(result.setlist.count) for page: \(page)")
//        allSetlists.append(contentsOf: result.setlist)
//        await Task.sleep(1_000_000_000)
//    }
//
//    return allSetlists
//}
