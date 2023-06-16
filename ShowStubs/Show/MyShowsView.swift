//
//  MyShowsView.swift
//  ShowStubs
//
//  Created by Michael on 6/15/23.
//

import SwiftUI
import SwiftData

struct MyShowsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(filter: #Predicate<LiveShow>{$0.attended == true}, sort: \.date, animation: .default) private var shows: [LiveShow]
//    @Query private var shows: [Show]
    
    @State var selected: LiveShow?

    var body: some View {

        NavigationStack {
            List {
                LiveShows(shows: shows, showName: true)
            }
            .navigationDestination(item: $selected) { liveShow in
                List {
                    SetsView(sets: liveShow.sets)
                }
            }
        }
    }
}

#Preview {
    MyShowsView()
}

//List {
//    ForEach(groupedSetlists.sorted(by: { $0.key < $1.key }), id: \.key) { (tour, setlists) in
//        Section {
//            ForEach(setlists){ setlist in
//                VStack(alignment: .leading) {
//                    Text(setlist.sets.count.description + "Sets")
//                    Text(setlist.date?.formatted(date: .numeric, time: .omitted) ?? "")
//                }
//            }
//        } header: {
//            Text(tour)
//        }
//    }
//}
