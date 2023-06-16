//
//  ShowStubsApp.swift
//  ShowStubs
//
//  Created by Michael on 6/14/23.
//

import SwiftUI
import SwiftData
import SetlistFMKit

@main
 struct ShowStubsApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(ShowData.container)
    }
}
