//
//  MyArtistsView.swift
//  ShowStubs
//
//  Created by Michael on 6/14/23.
//

import SwiftUI
import SwiftData
import SetlistFMKit

struct MyArtistsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var artists: [Artist]
    
    @State private var showSearch = false
        
    var body: some View {
        NavigationStack {
            List {
                ForEach(artists) { artist in
                    NavigationLink {
                        ArtistView(artist: artist)
                    } label: {
                        ArtistCell(artist: artist)
                    }
                }
                    .onDelete(perform: deleteItems)

            }
            .toolbar {
#if os(iOS)
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
#endif
                ToolbarItem {
                    Button {
                        showSearch = true
                    } label: {
                        Label("Add Custom", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showSearch) {
                SearchArtists()
            }
        }
    }
}

extension MyArtistsView {
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(artists[index])
            }
        }
    }
}

#Preview {
    MyArtistsView()
        .previewContainer()

}
