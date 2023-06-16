//
//  ArtistView.swift
//  ShowStubs
//
//  Created by Michael on 6/14/23.
//

import SwiftUI
import SwiftData
import SetlistFMKit

struct ArtistView: View {
    @Environment(\.modelContext) private var modelContext

    let artist: Artist

    var body: some View {
        VStack {
            HStack {
                Text(artist.name)
                    .font(.largeTitle)
            }
            List {
                LiveShows(shows: artist.shows)
            }
        }
        .task {
            do {

                guard self.artist.shows.isEmpty else {return}
                let result = try await SetlistFMClient.shared.getArtistSetlists(
                    mbid: artist.id,
                    pageNumber: 1
                )
                let setlists = result.setlist.compactMap {
                    let show = LiveShow(from: $0, artist: self.artist.name)
                    return show
                }
                self.artist.shows.append(contentsOf: setlists)
 
                try? modelContext.save()
            } catch {
                print(error.localizedDescription)
            }

        }
    }
}

#Preview {
    ModelPreview { artist in
        ArtistView(artist: artist)
    }
}
