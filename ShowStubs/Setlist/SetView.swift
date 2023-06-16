//
//  SetsView.swift
//  ShowStubs
//
//  Created by Michael on 6/15/23.
//

import SwiftUI
import SetlistFMKit
import SwiftData

struct SetsView: View {
    let sets: [Set]

    var body: some View {
        ForEach(sets, id: \.name) { set in
            Section(set.name ?? "Encore") {
                ForEach(set.songs, id: \.name) { song in
                    VStack(alignment: .leading) {
                        Text(title(for: song, set: set))
                        if !song.info.isEmpty {
                            Text(song.info)
                        }
                    }
                    
                }
            }
        }
    }
    
    func title(for song: Song, set: Set) -> String {
        if let name = song.name {
            return name
        }
        if let index = set.songs.firstIndex(of: song) {
            return "Song #\(index)"
        } else {
            return "Song"
        }
    }
        
}



#Preview {
    SetsView(sets: [])
}
