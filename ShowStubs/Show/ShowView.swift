//
//  ShowView.swift
//  ShowStubs
//
//  Created by Michael on 6/15/23.
//

import SwiftUI

struct ShowView: View {
    @Environment(\.modelContext) private var modelContext
    let show: LiveShow
    var body: some View {

        List {
            Group {
                LabeledContent("Artist", value: show.artistName)
                LabeledContent("Tour", value: show.tour ?? "--")
                LabeledContent("Date", value: show.date.formatted(date: .complete, time: .omitted))
                LabeledContent("Venue", value: show.venue ?? "--")
            }
            if let info = show.info {
                Text(info)
            }
            SetsView(sets: show.sets)
        }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(show.attended ? "Un-Attend" : "Mark Attended") {
                        show.attended.toggle()
                        try? modelContext.save()
                    }
                }
            }
            .navigationTitle(show.name)
    }
}

#Preview {
    ModelPreview { show in
        ShowView(show: show)
    }
}
