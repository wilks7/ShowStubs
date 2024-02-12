//
//  SetsView.swift
//  ShowStubs
//
//  Created by Michael on 6/15/23.
//

import SwiftUI
import SetlistFMKit
import SwiftData
import MusicAPI

struct SetsView<S:MusicAPI.Setlist>: View where S.S:Equatable {
    let sets: [S]

    var body: some View {
        ForEach(sets, id: \.name) { set in
            Section(set.name ?? "Encore") {
                ForEach(set.songs, id: \.name) { song in
                    VStack(alignment: .leading) {
                        Text(title(for: song, set: set))
                        if let info = song.info {
                            Text(info)
                        }
                    }
                    
                }
            }
        }
    }
    
    func title(for song: S.S, set: S) -> String {
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


//
//#Preview {
//    ModelPreview {
//        SetsView(sets: [$0])
//    }
//}
