//
//  ArtistDetails.swift
//  ShowStubs
//
//  Created by Michael on 6/17/23.
//

import SwiftUI
import MusicAPI

struct ArtistDetails<A:MusicAPI.Artist>: View {
    let artist: A
    var imageSize: CGFloat = 100
    @State var editMode = false
    
    let displayFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        return dateFormatter
    }()
    
    
    var body: some View {
        VStack {
            HStack {
                Rectangle().fill(Color.indigo)
                    .frame(width: imageSize, height: imageSize)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                VStack(alignment: .leading) {
                    Text(artist.name)
    //                Text(artist.sortName ?? "")
    //                Text(artist.id)
    //                    .font(.caption2)
//                    Text(artist.type ?? "Artist")
                    Text(artist.disambiguation ?? "Info")
//                    if let formed = artist.formed {
//                        Text(displayFormatter.string(from: formed))
//                    }
//                    if let ended = artist.ended {
//                        Text(displayFormatter.string(from: ended))
//                    }
                }
                Spacer()
            }
            .padding()
            if let artist = artist as? Artist {
                if editMode {
                    ArtistColorPicker(artist: artist)
                }

            }
        }
    }
}
extension ArtistDetails where A == Artist {
    init(artist: Artist) {
        self.artist = artist
    }
}

import MusicBrainzKit
extension ArtistDetails where A == MBArtist {
    init(mbArtist: MBArtist){
        self.artist = mbArtist
    }
}

import SetlistFMKit
extension ArtistDetails where A == FMArtist {
    init(fmArtist: FMArtist) {
        self.artist = fmArtist
    }
}


#Preview {
    ModelPreview {
        let artist: Artist = $0
        ArtistDetails(artist: artist)
    }
}
