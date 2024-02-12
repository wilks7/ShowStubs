//
//  SearchViewModel.swift
//  ShowStubs
//
//  Created by Michael Wilkowski on 6/21/23.
//

import Foundation
import Combine
import SetlistFMKit
import SwiftUI
import MusicBrainzKit

protocol Searchable: Identifiable, Hashable, Decodable {
    var id: String {get}
    var name: String {get}
}

protocol SearchableService {
    associatedtype Results: Searchable
    func fetchSearch(term: String) async throws -> [Results]
}



class SearchModel<S:SearchableService>: ObservableObject {
    
    @Published var searchTerm: String = ""
    @Published var results: [S.Results] = []
    
    private var subscription = Swift.Set<AnyCancellable>()
    let service: S
    
    var page: Int = 1
    var total: Int = 1
    
    init(service: S) {
        self.service = service
        $searchTerm
//            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] term in
                self?.search(for: term)
        }.store(in: &subscription)
    }
    
    private func search(for term: String) {
        Task {@MainActor in
            let results = try await service.fetchSearch(term: term)
            let newResults = results.filter { !self.results.contains($0) }
            self.results.append(contentsOf: newResults)
        }
    }
}

enum VenueSearchOptions: String, CaseIterable {
    case name
}
extension FMVenue: Searchable {}
extension FMArtist: Searchable {}
extension MBArtist: Searchable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: MBArtist, rhs: MBArtist) -> Bool {
        lhs.id == rhs.id
    }
}
extension FMSetlist: Searchable {
    var name: String { title }    
}
