//
//  LiveShowList.swift
//  ShowStubs
//
//  Created by Michael on 6/17/23.
//

import SwiftUI

struct LiveShowList: View {
    let shows: [LiveShow]
    @Binding var grouped: LiveShowGroup?
    
    var body: some View {
        if let grouped {
            let sorted = groupedShows.sorted{ $0.key < $1.key }
            ForEach(sorted, id: \.key) { (groupKey, shows) in
                ShowsSection(shows: shows, grouped: grouped, group: groupKey)
            }
        } else {
            ForEach(shows) { liveshow in
                NavigationLink {
                    LiveShowView(show: liveshow)
                } label: {
                    EventCell(show: liveshow)
                }
            }
        }
    }
    
    private struct ShowsSection: View {
        @Environment(\.modelContext) private var modelContext
        var shows: [LiveShow]
        let grouped: LiveShowGroup

        let group: String
        
        @State var expanded = true
                
        var body: some View {
            Section(isExpanded: $expanded) {
                ForEach(shows.sorted(by: {$0.date < $1.date}), id: \.id) { show in
                    NavigationLink {
                        LiveShowView(show: show)
                    } label: {
                        EventCell(show: show)
                    }
                }
            } header: {
                Button{
                    expanded.toggle()
                } label: {
                    HStack {
                        Text(group)
                        Spacer()
                        Image(systemName: expanded ? "chevron.down" : "chevron.right")
                    }
                    .foregroundStyle(.gray)
                    .font(.subheadline)
                }
            }
        }
    }
}

extension LiveShowList {
    var groupedShows: Dictionary<String, [LiveShow]> {
        Dictionary(grouping: shows) { show in
            switch grouped {
            case .year:
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy"
                return dateFormatter.string(from: show.date)
            case .month:
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMMM yyyy"
                return dateFormatter.string(from: show.date)
//            case .venue:
//                return show.venue?.name ?? "Venue"
//            case .tour:
//                return show.tour?.name ?? "Tour"
            case .attended:
                return show.attended ? "Attended":"Missed"
            case .artist:
                return show.artist?.name ?? "Artist"
            default:
                return show.artist?.name ?? "Unknown"
            }
        }
    }
}



extension LiveShowList {
    init(shows: [LiveShow]) {
        self.shows = shows
        self._grouped = .constant(nil)
    }
}

#Preview {
    ModelPreview {
        LiveShowList(shows: [$0], grouped: .constant(.artist))
    }
}
