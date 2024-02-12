//
//  ArtistShowsList.swift
//  ShowStubs
//
//  Created by Michael Wilkowski on 6/23/23.
//

import SwiftUI
import SetlistFMKit
import SwiftData
import DebouncedOnChange

struct ArtistView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var stored: [LiveShow]

    let artist: Artist
    @ObservedObject var model: SearchSetlists
    
    @State private var selected: FMSetlist?
    @State private var showSearch = false
    
    var body: some View {
        NavigationStack {
            if showSearch {
                SearchSetlistFilterView(filters: $model.filter){
                    model.reset()
                    model.fetch()
                }
            }
            List {
                ForEach(groupedShows, id: \.key) { (month, shows) in
                    Section(month) {
                        ForEach(shows) { fmSetlist in
                            Button {
                                self.selected = fmSetlist
                            } label: {
                                EventCell(show: fmSetlist)
                            }
                        }
                    }
                }

                if !model.allLoaded {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .onAppear {
                            model.loadMore()
                        }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(systemName: "magnifyingglass") {
                        withAnimation {
                            showSearch.toggle()
                        }
                    }
                }
            }
            .sheet(item: $selected) { setlist in
                VStack {
                    Text(setlist.name)
                    Text(setlist.date.formatted())
                }
                .navigationToolbar{
                    ToolbarItem(placement: .topBarTrailing) {
                        if !stored.map { $0.id }.contains(setlist.id) {
                            Button(systemName: "plus") {
                                let show: LiveShow = ShowAPI.liveShow(from: setlist, for: artist)
                                modelContext.insert(show)
                                self.selected = nil
                            }
                        }
                    }
                }
            }
            .navigationTitle(artist.name)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBar(color: artist.color)
        }
    }
        
    private let dateFormatter: DateFormatter = {
        let fmt = DateFormatter()
        fmt.dateFormat = "MMMM yyyy"
        return fmt
    }()
    
    var groupedShows: [(key: String, value: [FMSetlist])] {
        let dictionary = Dictionary(grouping: artist.setlists) {
            dateFormatter.string(from: $0.date)
        }
        return dictionary.sorted{
            let lhs = dateFormatter.date(from: $0.key)!
            let rhs = dateFormatter.date(from: $1.key)!
            return lhs > rhs
        }
    }
}
extension ArtistView {
    
    init(artist: Artist, model: SearchSetlists? = nil) {
        self.artist = artist
        if let model {
            self.model = model
        } else {
            self.model = SearchSetlists(artistID: artist.id)
        }
    }
}


#Preview {
    ModelPreview {
        ArtistView(artist: $0, model: PreviewSearchModel(artistID: $0.id))
    }
}
