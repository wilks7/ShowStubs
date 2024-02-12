//
//  LiveShowCell.swift
//  ShowStubs
//
//  Created by Michael on 6/17/23.
//

import SwiftUI
import MusicAPI

struct EventCell: View {
    let title: String
    var venue: String?
    var tour: String?
    var hexColor: String = Color.indigo.toHex()!
    
    var isList: Bool = true
    
    var body: some View {
        if isList {
            listCell
        } else {
            gridCell
        }
    }
    
    
    @ViewBuilder
    var listCell: some View {
        VStack(alignment: .leading) {
            if let venue {
                Text(venue)
                    .bold()
                    .font(.title3)
                    .multilineTextAlignment(.leading)
            }
            Text(title)
                .fontWeight(.semibold)
            if let tour {
                Text(tour)
                    .font(.subheadline)
            }
        }
    }
    
    var gridCell: some View {
        VStack(alignment: .leading) {
            if let venue {
                Text(venue)
                    .bold()
                    .font(.title3)
                    .multilineTextAlignment(.leading)
            }
            Text(title)
                .fontWeight(.semibold)
            if let tour {
                Text(tour)
                    .font(.subheadline)
            }
        }
        .background(Color(hexColor))
    }
    
    var stubCell: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .bottom) {
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.largeTitle)
                    Text(venue ?? "")
                    Text(tour ?? "")
                }
                Spacer()
//                Text("New York, NY")
            }

            Spacer()
        }
        .background(Color(hex: hexColor))
    }
}

//extension EventCell where E == LiveShow {
//    init(show: LiveShow, isList: Bool = true) {
//        self.show = show
//        self.isList = isList
//    }
//}

import SetlistFMKit
extension EventCell {
    init(show: FMSetlist, isList: Bool = true) {
        self.title = show.title
        self.tour = show.tour?.name
        self.venue = show.venue?.name
        self.hexColor = show.hexColor ?? Color.indigo.toHex()!
        self.isList = isList
    }
    
    init(show: LiveShow, isList: Bool = true) {
        self.title = show.title
        self.tour = show.tour?.name
        self.venue = show.venue?.name
        self.hexColor = show.hexColor ?? Color.indigo.toHex()!
        self.isList = isList
    }
}

//#Preview {
//    ModelPreview { show in
//        let _show: LiveShow =  show
//        LiveShowCell(show: _show)
//    }
//}
//
//VStack(alignment: .leading) {
//    Text(setlist.eventDate.formatted(date: .numeric, time: .omitted))
//        .fontWeight(.semibold)
//    if let venue = setlist.venue?.name {
//        Text(venue)
//            .font(.subheadline)
//    }
//    if let tour = setlist.tour?.name {
//        Text(tour)
//    }
//    if let sets = setlist.sets?.set, !sets.isEmpty {
//        Text("\(sets.count) Sets")
//        Text("\(sets.flatMap { $0.song }.count) Songs")
//    }
//}
