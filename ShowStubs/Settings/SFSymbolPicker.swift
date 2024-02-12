//
//  SFSymbolPicker.swift
//  ShowStubs
//
//  Created by Michael Wilkowski on 6/23/23.
//

import SwiftUI
import UIKit


struct SFSymbolPicker: View {
    @Environment(\.dismiss) private var dismiss
    
    @Bindable var artist: Artist
    
    let symbols: [String] = {
        if let sfSymbolsBundle = Bundle(identifier: "com.apple.SFSymbolsFramework"),
           let bundlePath = sfSymbolsBundle.path(forResource: "CoreGlyphs", ofType: "bundle"),
           let bundle = Bundle(path: bundlePath),
           let resourcePath = bundle.path(forResource: "symbol_search", ofType: "plist"),
           let plist = NSDictionary(contentsOfFile: resourcePath),
           let symbolNames = plist.allKeys as? [String] {
            return symbolNames
        }
        return []
    }()
    
    let gridLayout = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridLayout, spacing: 16) {
                ForEach(symbols, id: \.self) { symbol in
                    Button {
                        artist.symbol = symbol
                        dismiss()
                    } label: {
                        Image(systemName: symbol)
                            .font(.system(size: 20))
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    ModelPreview {
        SFSymbolPicker(artist: $0)
    }
}
