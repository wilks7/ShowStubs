//
//  MyShowsView.swift
//  ShowStubs
//
//  Created by Michael on 6/17/23.
//

import SwiftUI
import SwiftData

struct MyShowsView: View {
    @Environment(\.isSearching) private var isSearching
    @Query(sort: \.date) private var shows: [LiveShow]
    
    let artist: Artist?
    
    @State private var showAdd = false
    @State private var grouped: LiveShowGroup? = .venue
    @State private var isList = true

    var liveShows: [LiveShow] {
        if let artist {
            shows.filter{$0.artist.id == artist.id}
        } else {
            shows
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if isSearching {
                    LiveShowGroupPicker(group: $grouped)
                }
                ShowsView(myShows: liveShows, grouped: $grouped, isList: $isList)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(systemName: isList ? "square.grid.2x2" : "list.star") {
                        isList.toggle()
                    }
                }
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showAdd = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .navigationTitle(artist?.name ?? "All Shows")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBar(color: artist?.color ?? .indigo)
//            .sheet(isPresented: $showAdd) {
//                SearchSetlists(artist: artist)
//            }
        }
    }

}
extension MyShowsView {
struct ShowsView: View {
    
    let myShows: [LiveShow]
    @Binding var grouped: LiveShowGroup? 

    @State private var searchTerm: String = ""
    @Binding var isList: Bool
    
    var body: some View {
        Group {
            if isList {
                listView
            } else {
                gridView
            }
        }
        .searchable(text: $searchTerm)
//       .searchable(text: $searchTerm, placement: .navigationBarDrawer(displayMode: .automatic))
    }
    
    @ViewBuilder
    var gridView: some View {
        let collumns: [GridItem] = [.init(), .init()]
        ScrollView(.vertical) {
            LazyVGrid(columns: collumns){
                ForEach(myShows) { show in
                    NavigationLink {
                        LiveShowView(show: show)
                    } label: {
                        EventCell(show: show, isList: false)
                    }
                }
            }
        }
        .padding(.top)
    }
    
    
    var listView: some View {
        VStack(spacing: 0) {
//                LiveShowGroupPicker(group: $grouped)
//                    .padding(.bottom)
//                    .padding(.horizontal)
            List {
                LiveShowList(shows: myShows, grouped: .constant(nil))
            }
        }
    }
}
}

struct LiveShowGroupPicker: View {
    @Binding var group: LiveShowGroup?
    
    var selection: [LiveShowGroup] = [
        .venue, .tour, .year, .month, .attended
    ]
    
    var body: some View {
        Picker("Sort", selection: $group) {
//            Text("None")
//                .tag(nil as LiveShowGroup?)
            ForEach(selection) { type in
                Text(type.title)
                    .tag(type as LiveShowGroup? )
            }
        }
        .pickerStyle(.segmented)
    }
}

#Preview {
    ModelPreview {
        MyShowsView(artist: $0)
    }
}
