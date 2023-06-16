//
//  ArtistSetlists.swift
//  ShowStubs
//
//  Created by Michael on 6/15/23.
//

import SwiftUI
import SetlistFMKit

struct LiveShows: View {
    let shows: [LiveShow]
    var showName: Bool = false
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        return dateFormatter
    }()
    
    var body: some View {
        let groupedShows: Dictionary<String, [LiveShow]> = Dictionary(grouping: shows) { show in

            return dateFormatter.string(from: show.date)

        }
        ForEach(groupedShows.sorted(by: { $0.key < $1.key }), id: \.key) { (date, shows) in
            Section {
                ForEach(shows.sorted(by: {$0.date < $1.date}), id: \.id) { show in
                    NavigationLink {
                        ShowView(show: show)
                    } label: {
                        VStack(alignment: .leading) {
                            if showName {
                                Text(show.artistName)
                                    .bold()
                            }
                            Text(show.name)
                                .bold()
                            Text(show.date.formatted(date: .numeric, time: .omitted))
                                .font(.subheadline)
                        }
                    }
                }
            } header: {
                Text(date)
            }
        }
    }

}


#Preview {
    NavigationStack {
        LiveShows(shows: [])
    }
}
