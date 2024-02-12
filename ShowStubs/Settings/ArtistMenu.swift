//
//  ArtistMenu.swift
//  ShowStubs
//
//  Created by Michael Wilkowski on 6/22/23.
//

import SwiftUI
import SwiftData

struct ArtistMenu: View {
    @Environment(\.modelContext) private var modelContext
    @Query var artists: [Artist]
    @Binding var artist: Artist?
    var searchTapped: ()->Void
    
    @State private var showSearch = false

    var body: some View {
        Menu(artist?.name ?? "Select Artist") {
            ForEach(artists) { _artist in
                Button {
                    UserDefaults.standard.setValue(_artist.id, forKey: "lastSelected")
                    self.artist = _artist

                } label: {
                    Label(_artist.name, systemImage: _artist.symbol)
                }
            }
            if artists.count > 1 {
                Divider()
                Button("All Artists") {
                    self.artist = nil
                }
            }

            Divider()
            Button(action: searchTapped) {
                Label("Add Artist", systemImage: "plus")
            }
        }

    }
}

#Preview {
    ModelPreview {
        ArtistMenu(artist: .constant($0)){}
    }
}
