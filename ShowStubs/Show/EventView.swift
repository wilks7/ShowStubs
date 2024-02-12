//
//  ShowView.swift
//  ShowStubs
//
//  Created by Michael on 6/15/23.
//

import SwiftUI
import SwiftData
import SetlistFMKit
import MusicBrainzKit
import MusicAPI
import MapKit

struct LiveShowView: View {
    @Environment(\.modelContext) private var modelContext
    
    let show: LiveShow
    
    var body: some View {

        List {
            Group {
                LabeledContent("Artist", value: show.artist.name)
                LabeledContent("Date", value: show.date.formatted(date: .complete, time: .omitted))
                if let tour = show.tour {
                    LabeledContent("Tour", value: tour.name)
                }
                if let venue = show.venue {
                    LabeledContent("Venue", value: venue.name)
                    LabeledContent("Location", value: venue.city.name + ", \(venue.city.countryName)" )
                        .onTapGesture {
                            print("Show Location")
                        }
                    if let lat = venue.city.latitude, let lon = venue.city.longitude {
                        LiveShowMap(latitude: lat, longitude: lon)
                            .frame(height: 200)
                    }
                }
            }
            EditLiveShow(show: show)
//            else if let fmSetlist = show as? FMSetlist {
//                EditFMSetlist(setlist: fmSetlist, artist: artist)
//            }

            SetsView(sets: show.setlist)
        }

//        .toolbar {
//            ToolbarItem(placement: .primaryAction) {
//
//            }
//        }
            .navigationTitle(show.title)
    }
    
    struct LiveShowMap: View {
        @State var region: MKCoordinateRegion
        
        init(latitude: Double, longitude: Double) {
            self._region = State(initialValue:   MKCoordinateRegion(
                center:  CLLocationCoordinate2D(
                  latitude: 37.789467,
                  longitude:-122.416772
                ),
                span: MKCoordinateSpan(
                  latitudeDelta: 0.08,
                  longitudeDelta: 0.08
               )
                )
                                 )
        }
                                 
        var body: some View {
            Map(coordinateRegion: $region)
        }
    }
}

struct EditFMSetlist: View {
    @Environment(\.dismiss) private var dismss
    @Environment(\.modelContext) private var modelContext
    
    let setlist: FMSetlist
    let artist: Artist
    
    @State private var attended = false
    var body: some View {
        Toggle("Attended", isOn: $attended)
            .onChange(of: attended) { oldValue, newValue in
                if newValue {
                    let id = setlist.id
                    if let object = try! modelContext.fetch(FetchDescriptor<LiveShow>(predicate: #Predicate{ $0.id == id } ) ).first {
                        object.attended = newValue
                    } else {
                        modelContext.insert( ShowAPI.liveShow(from: setlist, for: artist) )
                        dismss()
                    }
                }
            }
    }
}
struct EditLiveShow: View {
    @Bindable var show: LiveShow
    
    var body: some View {
        HexColorPicker(hexColor: $show.hexColor)
    }
}

//extension LiveShowView where Show == FMSetlist {
//    
//
//    init(setlist: FMSetlist, artist: Artist) {
//        self.show = setlist
//        self.artist = artist
//        self.fromSearch = true
//    }
//}

//extension LiveShowView where Show == LiveShow {
//    init(liveshow: LiveShow) {
//        self.show = liveshow
//        self.artist = liveshow.artist
//        self.fromSearch = false
//    }
//    
//}
#Preview {
    ModelPreview { show in
        let liveShow: LiveShow = show
        Text("Test")
//        LiveShowView<LiveShow>(liveshow: liveShow)
    }
}
