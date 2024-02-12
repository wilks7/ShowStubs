//
//  SearchArtists.swift
//  ShowStubs
//
//  Created by Michael on 6/15/23.
//

import SwiftUI
import SetlistFMKit
import SwiftData
import MusicBrainzKit
import Combine


struct SearchArtistsView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @Query private var stored: [Artist]

    @StateObject var model = SearchArtist()
    
    @Binding var artist: Artist?
    

    var body: some View {
        NavigationStack {
            List {
                ForEach(model.searchResults) { mbArtist in
                    let artist = Artist(mbArtist: mbArtist)

                    NavigationLink {
                        ArtistDetails(artist: artist)
                        .toolbar {
                            ToolbarItem(placement: .primaryAction) {
                                Button("Add"){
                                    withAnimation {
                                        modelContext.insert(artist)
                                        try? modelContext.save()
                                        self.artist = artist
                                        dismiss()
                                    }
                                }
                            }
                        }
                        .navigationTitle(artist.name)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(mbArtist.sortName ?? mbArtist.name)
                            if let type = mbArtist.type {
                                HStack {
                                    Text(type)
                                    if let country = mbArtist.country {
                                        Text(country)
                                    }
                                }
                            }
                        }
                    }
                    .disabled(stored.map { $0.id }.contains(mbArtist.id))
                }
            }
            .searchable(text: $model.searchTerm)
            .navigationTitle("Search")
        }
    }
}

class SearchArtist: ObservableObject {
    @Published var searchTerm: String = ""
    @Published var searchResults: [MBArtist] = []
    @Published var options: ArtistSearchOptions = .name
    
    var subscription = Swift.Set<AnyCancellable>()

    
    init() {
        $searchTerm
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] term in
                self?.fetchSearch(term: term)
        }.store(in: &subscription)
    }
    
    func loadMore(){
        fetchSearch(term: searchTerm)
    }
    
    var page: Int = 1
    var total: Int = 1
    
    func fetchSearch(term: String) {
        guard !searchTerm.isEmpty else { return }

        let query = ["artistName":searchTerm]

        Task{ @MainActor in
            do {
                let artists: [MBArtist] = try await MusicBrainzClient.shared.search(parameters: query)
//                let mbArtists: [MBArtist] = try await MusicBrainzClient.shared.search(
                self.searchResults = artists
            } catch {
                print("⚠️ \(error.localizedDescription)")
            }
        }
    }

    
}

enum ArtistSearchOptions: String, CaseIterable {
    case name
}


//
//#Preview {
//    SearchArtistsView
//}
