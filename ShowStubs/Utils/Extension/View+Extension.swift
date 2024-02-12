//
//  View+Extension.swift
//  ShowStubs
//
//  Created by Michael Wilkowski on 6/22/23.
//

import Foundation
import SwiftUI

extension View {
    func navigationBar(color: Color) -> some View {
        self.toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(
                color,
                for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
    }
    
    func navigationToolbar<Toolbar>(@ToolbarContentBuilder content: () -> Toolbar) -> some View where Toolbar : ToolbarContent {
        NavigationStack {
            self
            .toolbar(content: content)
        }
    }

}
