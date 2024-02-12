//
//  FilterGroups.swift
//  ShowStubs
//
//  Created by Michael Wilkowski on 6/23/23.
//

import Foundation
import SetlistFMKit

enum LiveShowGroup: String, CaseIterable, Identifiable {
    var id: String {self.rawValue}
    case year, month, venue, tour, attended, artist
    var title: String { self.rawValue.capitalized }
}

enum SearchSetlistParam: String, CaseIterable, Identifiable {
    var id: String {self.rawValue}
    case year, month, date, state, city, venue, tour
}



enum SetlistOptions: String, CaseIterable, Identifiable, Equatable {
    var id: String { self.rawValue }
    case year, tour
}
