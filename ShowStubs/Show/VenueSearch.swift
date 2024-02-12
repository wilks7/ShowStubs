////
////  VenueSearch.swift
////  ShowStubs
////
////  Created by Michael Wilkowski on 6/21/23.
////
//
//import SwiftUI
//import SetlistFMKit
//
//struct VenueSearch: View {
//    @StateObject var model = SearchVenueModel()
//    @Binding var selected: FMVenue?
//
//    var body: some View {
//        List {
//            ForEach(model.searchResults, id: \.name) { venue in
//                Button(venue.name) {
//                    self.selected = venue
//                }
//            }
//        }
//        .searchable(text: $model.searchTerm)
//    }
//}
//
//#Preview {
//    VenueSearch(selected: .constant(nil))
//}
