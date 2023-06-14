//
//  ShowStubsApp.swift
//  ShowStubs
//
//  Created by Michael on 6/14/23.
//

import SwiftUI
import SwiftData

@main
struct ShowStubsApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Item.self)
    }
}
