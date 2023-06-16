//
//  ArtistCell.swift
//  ShowStubs
//
//  Created by Michael on 6/16/23.
//

import SwiftUI
import SetlistFMKit


struct ArtistCell<A:ArtistProtocol>: View {
    let artist: A
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(artist.name)
            if let disambiguation = artist.disambiguation {
                Text(disambiguation)
            }
//            if let lifespan = artist.lifeSpan {
//                Text(lifespan.begin ?? "" + (lifespan.end ?? "" ))
//            }
        }
    }
}

protocol ArtistProtocol {
    var name: String {get}
    var disambiguation: String? {get}
}

extension Artist: ArtistProtocol {}
extension MBArtist: ArtistProtocol {}

#Preview {
    ModelPreview { artist in
        List {
            ArtistCell<Artist>(artist: artist)
        }
    }
    
}
