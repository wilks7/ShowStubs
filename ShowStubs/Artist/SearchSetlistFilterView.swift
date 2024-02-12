//
//  SearchSetlistFilterView.swift
//  ShowStubs
//
//  Created by Michael Wilkowski on 6/26/23.
//

import SwiftUI
import Observation

@Observable class SearchSetlistFilter: Equatable {
    static func == (lhs: SearchSetlistFilter, rhs: SearchSetlistFilter) -> Bool {
        return lhs.date == rhs.date &&
        lhs.year == rhs.year &&
        lhs.city == rhs.city &&
        lhs.venue == rhs.venue &&
        lhs.tour == rhs.tour
    }
    
    var date: Date? = nil
    var year: String? = nil
    var city: String = ""
    var venue: String = ""
    var tour: String = ""
    
    var skipFilter: Bool {
        return date == nil &&
        year == nil &&
        city.isEmpty &&
        venue.isEmpty &&
        tour.isEmpty
    }
    
    

}

struct SearchSetlistFilterView: View {
    @Binding var filters: SearchSetlistFilter
    var searchTapped: ()->Void
    
    var date: Binding<Date> {
        .init {
            filters.date ?? Date.now
        } set: { newValue in
            filters.date = newValue
        }
    }
    
    var body: some View {
        Form {
//            DatePicker("Date", selection: date)
            if filters.date != nil {
                HStack {
                    DatePicker("Date", selection: date)
                    Button(systemName: "x.circle") {
                        filters.date = nil
                    }
                }
                

            } else {
                LabeledContent("Date") {
                    Button {
                        filters.date = Date()
                    } label: {
                        Text("Select a date")
                            .foregroundColor(.blue)
                    }
                }
                Picker("Year", selection: $filters.year) {
                    Text("Select a year")
                        .tag(nil as String?)
                    ForEach(1950...2020, id: \.self) {
                        Text(String($0))
                            .tag(String($0) as String?)
                    }
                }
                .pickerStyle(.menu)
            }
            LabeledContent("Venue") {
                HStack {
                    Spacer()
                    TextField("", text: $filters.venue, prompt: Text("Madison Square Garden"))
                    if !filters.venue.isEmpty {
                        Button(systemName: "x.circle") {
                            filters.venue = ""
                        }
                    }
                }
            }
            LabeledContent("City") {
                HStack {
                    Spacer()
                    TextField("", text: $filters.city, prompt: Text("New York"))
                    if !filters.city.isEmpty {
                        Button(systemName: "x.circle") {
                            filters.city = ""
                        }
                    }
                }
            }
            Button("Search"){
                searchTapped()
            }
        }
    }
}
//
//#Preview {
//    SearchSetlistFilterView()
//}
