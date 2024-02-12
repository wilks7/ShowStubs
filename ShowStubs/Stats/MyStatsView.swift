//
//  MyStatsView.swift
//  ShowStubs
//
//  Created by Michael Wilkowski on 6/23/23.
//

import SwiftUI
import SwiftData
import Charts

struct MyStatsView: View {
    @Query private var liveShows: [LiveShow]
    var artist: Artist?
    
    var shows: [LiveShow] {
        if let artist {
            liveShows.filter{$0.artist.id == artist.id}
        } else {
            liveShows
        }
    }
    
    private var allSongs: [Song] {
        shows.flatMap{$0.setlist}.flatMap{$0.songs}
    }
    
    var body: some View {
        NavigationStack {
            List {
                Text(allSongs.count.description + "Songs")
            }
            .navigationTitle(artist?.name ?? "All Shows")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBar(color: artist?.color ?? .indigo)
        }
    }
}

#Preview {
    MyStatsView()
}
