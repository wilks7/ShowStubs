//
//  ContentView.swift
//  ShowStubs
//
//  Created by Michael on 6/14/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query private var artists: [Artist]
    @State private var selected: Artist?
    @State private var showSearch = false
    
    var body: some View {
        Group {
            TabView {
                MyShowsView(artist: selected)
                    .tabItem { Label("Attended", systemImage: "ticket") }
                if let selected {
                    ArtistView(artist: selected)
                        .tabItem { Label("Shows", systemImage: "guitars") }
                } else {
//                    AllShowsView()
                }
                MyStatsView(artist: selected)
                    .tabItem { Label("Stats", systemImage: "chart.xyaxis.line") }
                SettingsView(selected: $selected)
                    .tabItem { Label("Settings", systemImage: "gear") }
            }
        }
        .onAppear(perform: loadLastArtist)
        .onChange(of: selected) {
            selected?.fetch()
        }
    }
    
    private func loadLastArtist(){
        let lastSelected = UserDefaults.standard.string(forKey: "lastSelected")
        self.selected = artists.first{$0.id == lastSelected }
    }
}

#Preview {
    ContentView()
}
