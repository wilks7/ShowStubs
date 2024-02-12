//
//  PreviewSearchModel.swift
//  ShowStubs
//
//  Created by Michael Wilkowski on 6/24/23.
//

import Foundation
import SetlistFMKit

class PreviewSearchModel: SearchSetlists {
    override func fetch() {
        Task {@MainActor in
            do {
                let data = Sample.PhishSetlistsJSON
                let result = try JSONDecoder().decode(FMSetlistsResult.self, from: data)
                
                self.results.append(contentsOf: result.setlist)
//
//                self.total = result.total
//                self.page += 1
            } catch {
                print(error)
            }
        }
    }
}
