//
//  ProxyService.swift
//  ShowStubs
//
//  Created by Michael Wilkowski on 6/29/23.
//

import Foundation
import SetlistFMKit

class ProxyService {
    private init(){}
    static let shared = ProxyService()
    
    private let base: String = "https://liveshow-api-3046ea0d71ba.herokuapp.com/"
    
    func fetchSetlists(for artistID: String, page: Int = 1) async throws -> [FMSetlist] {
        let url = URL(string: base + "artist/\(artistID)?p=\(page)")!
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let decoder = JSONDecoder()
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            decoder.dateDecodingStrategy = .formatted(formatter)
            let result = try decoder.decode(Result.self, from: data)
            return result.setlists
        } catch {
            print(error)
            return []
        }

    }
    
    struct Result: Decodable {
        let setlists: [FMSetlist]
//        let total: Int
    }
}



struct MySetlist: Decodable {
    let id: String
    let eventDate: Double
}
