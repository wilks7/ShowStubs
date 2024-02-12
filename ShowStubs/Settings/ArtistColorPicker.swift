//
//  ArtistColorPicker.swift
//  ShowStubs
//
//  Created by Michael Wilkowski on 6/22/23.
//

import SwiftUI

struct ArtistColorPicker: View {
    
    @Bindable var artist: Artist
    
    var color: Binding<Color> {
        .init {
            artist.color
        } set: { newValue in
            if let hex = newValue.toHex() {
                artist.hexColor = hex
            }
        }
    }
    
    var body: some View {
        ColorPicker("Artist Color", selection: color)
    }
}
struct HexColorPicker: View {
    var title: String = "Color"
    @Binding var hexColor: String?
    
    var color: Binding<Color> {
        .init {
            Color(hex: hexColor ?? "") ?? Color.indigo
        } set: { newValue in
            if let hex = newValue.toHex() {
                hexColor = hex
            }
        }
    }
    
    var body: some View {
        ColorPicker(title, selection: color)
    }
    
}

#Preview {
    ModelPreview {
        ArtistColorPicker(artist: $0)
    }
}
