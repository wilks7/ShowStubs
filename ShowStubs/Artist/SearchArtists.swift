//
//  SearchArtists.swift
//  ShowStubs
//
//  Created by Michael on 6/15/23.
//

import SwiftUI
import SetlistFMKit
import SwiftData

struct SearchArtists: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var artists: [Artist]

    @State private var searchText = ""

    @State private var searchResults: [MBArtist] = []
    @State private var selected: MBArtist?

    var body: some View {
        NavigationStack {
            List {
                ForEach(searchResults, id: \.name) { artist in
                    Button {
                        self.selected = artist
                    } label: {
                        ArtistCell(artist: artist)
                    }
                }
            }
            .searchable(text: $searchText)
            .onSubmit(of: .search, searchArtists)
            .sheet(item: $selected) { artist in
                AddArtistView(artist: artist)
            }
        }
    }
    
    func searchArtists() {
        guard !searchText.isEmpty else {
            return
        }
        Task { @MainActor in
            do {
                let artists = try await MusicBrainzClient.shared.searchArtist(artist: searchText)
                self.searchResults = artists
            } catch {
                print("⚠️ \(error.localizedDescription)")
//                print(error)
            }
        }
    }
    

}

struct AddArtistView: View {
    @Environment(\.modelContext) private var modelContext

    let artist: MBArtist
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Text(artist.sortName ?? "")
                } header: {
                    Text(artist.id)
                        .font(.caption2)
                }
                Text(artist.type ?? "Solo")
                Text(artist.disambiguation ?? "Details")

                Text(artist.country ?? "")
                if let lifespan = artist.lifeSpan {
                    if let started = lifespan.begin {
                        Text("Formed: \(started)")
                    }
                    if let stopped = lifespan.end {
                        Text("Ended: \(stopped)")
                    }
                    if let ended = lifespan.ended {
                        Text("Musicing: \(ended ? "No" : "Yes")")
                    }
                }
                Button("Add"){
                    add(artist: artist)
                }
                .font(.largeTitle)
                .padding()
                .background(Color.indigo)
                .cornerRadius(16)
                
            }
            .navigationTitle(artist.name)
        }
    }
    
    private func add(artist: MBArtist) {
        let artist = Artist(artist: artist)
        withAnimation {
            modelContext.insert(artist)
            try? modelContext.save()
        }
    }
}

#Preview {
    SearchArtists()
}
#Preview("AddArtist"){
    AddArtistView(artist: MBArtist.Nirvana)
}
