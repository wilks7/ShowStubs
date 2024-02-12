//
//  SettingsView.swift
//  ShowStubs
//
//  Created by Michael Wilkowski on 6/22/23.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var selected: Artist?
    @State private var showSearch = false

    var body: some View {
        NavigationStack {
            Form {
                LabeledContent("Artist") {
                    ArtistMenu(artist: $selected) {
                        showSearch = true
                    }
                }
                if let selected {
                    Section(selected.name) {
                        ArtistColorPicker(artist: selected)
                        NavigationLink {
                            SFSymbolPicker(artist: selected)
                        } label: {
                            LabeledContent("Symbol") {
                                Image(systemName: selected.symbol)
                            }
                        }
                    }
                }
            }
            .sheet(isPresented: $showSearch) {
                SearchArtistsView(artist: $selected)
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBar(color: selected?.color ?? .indigo)
        }

    }
}

#Preview {
    ModelPreview {
        SettingsView(selected: .constant($0))
    }
}
