//
//  LiveShowsList.swift
//  ShowStubs
//
//  Created by Michael on 6/16/23.
//

import SwiftUI
import SetlistFMKit
import Combine
import MusicAPI
import MusicBrainzKit
import SwiftData


class SearchSetlists: ObservableObject {
    @Published var searchTerm: String = ""
    @Published var results: [FMSetlist] = []
    
    @Published var filter = SearchSetlistFilter()
    var page: Int = 1 {
        didSet {
            UserDefaults.standard.setValue(page, forKey: "\(artistID)_FMSetlist_Page")
        }
    }
    var total: Int = 1 {
        didSet {
            UserDefaults.standard.setValue(total, forKey: "\(artistID)_FMSetlist_Total")
        }
    }
    
    private let artistID: String
    private var kResultKey:String { "\(artistID)_FMSetlist_Results" }
    

    
    var allLoaded: Bool {
        results.count == total
    }
    
    init(artistID: String){
        self.artistID = artistID
        loadFetched()
        fetchAll(for: artistID)
    }
    
    private func loadFetched(){
        let page = UserDefaults.standard.integer(forKey: "\(artistID)_FMSetlist_Page")
        self.page = page == 0 ? 1:page
        let total = UserDefaults.standard.integer(forKey: "\(artistID)_FMSetlist_Total")
        self.total = total == 0 ? 1:total
    }
    
    func loadMore(){
        guard results.count < total else { return}
        fetch()
    }
    
    func reset(){
        self.page = 1
        self.total = 2
        self.results = []
    }
    
    func fetchAll(for artistID: String) {
        Task {
            do {
                let data = try await ProxyService.shared.fetchSetlists(for: artistID, page: page)
                self.results = data
            } catch {
                print(error)
            }
        }
    }
    
    func fetch() {
        Task {@MainActor in
            do {
//                print("PROXY: \(data.count)")
                
//                let result = try await SetlistFMClient.shared.searchSetlists(
//                    artistMbid: artistID,
//                    cityName: filter.city.isEmpty ? nil: filter.city,
//                    date: filter.date == nil ? nil : filter.date!.formatted(date: .numeric, time: .omitted),
//                    pageNumber: page,
//                    tourName: filter.tour.isEmpty ? nil: filter.tour,
//                    venueName: filter.venue.isEmpty ? nil: filter.venue,
//                    year: filter.year == nil ? nil: filter.year!
//                )
//                
//                self.results.append(contentsOf: result.setlist)
//                if let data = try? JSONEncoder().encode(self.results) {
//                    UserDefaults.standard.setValue(data, forKey: kResultKey)
//                }
//                
//                print("PAGE: \(self.page), RESULT: \(result.setlist.count) TOTAL: \(result.total)")
//                
//                self.total = result.total
//                self.page += 1
            } catch {
                print(error)
            }
        }
    }
}

struct AllSetlists {
    // Properties of FMSetlist struct
    
    static let pageSize = 20 // Number of setlists per page
    static let rateLimitDelay: TimeInterval = 5 // Delay between each page fetch (in seconds)
    
    // Fetch all pages of setlists and store them locally
    static func fetchAllSetlists(for artistID: String) async throws -> [FMSetlist] {
        var allSetlists: [FMSetlist] = [] // Array to store all setlists from all pages
        var currentPage = 1
        var totalResults = 0
        var totalPages = 0
        
        func fetchPage(page: Int) async throws -> FMSetlistsResult {
            // Call your async function to fetch a page of setlists
            // Replace `yourAsyncFetchFunction` with your actual function
            let pageSetlistsResult = try await SetlistFMClient.shared.searchSetlists(
                artistMbid: artistID,
                pageNumber: page
            )
            allSetlists.append(contentsOf: pageSetlistsResult.setlist)
            currentPage += 1
            
            // Check if there are more pages to fetch
            if currentPage <= totalPages {
                // Delay to respect rate limit
                await Task.sleep(UInt64(rateLimitDelay * 1_000_000_000))
                return try await fetchPage(page: currentPage)
            } else {
                return pageSetlistsResult
            }
        }
        
        // Fetch the first page to get the total results count
        let firstPageSetlistsResult = try await fetchPage(page: currentPage)
        totalResults = firstPageSetlistsResult.total
        
        // Calculate the total pages based on total results and page size
        totalPages = Int(ceil(Double(totalResults) / Double(pageSize)))
        
        // If there are remaining pages, fetch them
        if totalPages > 1 {
            currentPage += 1
            let remainingSetlistsResult = try await fetchPage(page: currentPage)
            allSetlists.append(contentsOf: remainingSetlistsResult.setlist)
        }
        
        return allSetlists
    }
}

