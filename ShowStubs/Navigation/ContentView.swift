//
//  ContentView.swift
//  ShowStubs
//
//  Created by Michael on 6/14/23.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            MyArtistsView()
                .tabItem { Label("Artists", systemImage: "music.mic") }
//            MySetlistsView()
//                .tabItem { Label("Setlists", systemImage: "music.note.list") }
            MyShowsView()
                .tabItem { Label("Shows", systemImage: "guitars") }
            Text("Profile")
                .tabItem { Label("Profile", systemImage: "person") }
        }
    }
}

#Preview {
    ContentView()
}
