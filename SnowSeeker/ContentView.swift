//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Edwin Przeźwiecki Jr. on 25/02/2023.
//

import SwiftUI

/// An implementation of an extension that allows limiting the default landscape layout split while being run on an iPhone:

/* extension View {
    @ViewBuilder func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
} */

/// Challenge 3:
enum SortOrder {
    case `default`, alphabetical, byCountry
}

struct ContentView: View {
    
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @StateObject var favorites = Favorites()
    
    @State private var searchText = ""
    
    /// Challenge 3:
    @State private var isShowingSortingOptions = false
    @State private var sortOrder = SortOrder.default
    
    /// Previous solution:
    /// Challenge 3:
        /* var filteredResorts: [Resort] {
            
            switch sortOrder {
                
            case .none:
                if searchText.isEmpty {
                    return resorts
                } else {
                    return resorts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
                }
            case .alphabetical:
                if searchText.isEmpty {
                    return resorts.sorted()
                } else {
                    return resorts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
                }
            case .byCountry:
                if searchText.isEmpty {
                    return resorts.sorted { $0.country < $1.country }
                } else {
                    return resorts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
                }
            }
        } */
    
    var filteredResorts: [Resort] {
            if searchText.isEmpty {
                return resorts
            } else {
                return resorts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
            }
        }
    
    /// Challenge 3:
    var sortedResorts: [Resort] {
        
        switch sortOrder {
            
        case .`default`:
            return filteredResorts
        case .alphabetical:
            return filteredResorts.sorted { $0.name < $1.name }
        case .byCountry:
            return filteredResorts.sorted { $0.country < $1.country }
        }
    }
    
    var body: some View {
        NavigationView {
            List(sortedResorts) { resort in
                NavigationLink {
                    ResortView(resort: resort)
                } label: {
                    /// Challenge 3:
                    ResortsView(resorts: resorts, resort: resort)
                }
            }
            .navigationTitle("Resorts")
            .searchable(text: $searchText, prompt: "Search for a resort")
            /// Challenge 3:
            .toolbar {
                Button {
                    isShowingSortingOptions = true
                } label: {
                    Label("Sort", systemImage: "arrow.up.arrow.down")
                }
            }
            /// Challenge 3:
            .confirmationDialog("Sorting order", isPresented: $isShowingSortingOptions) {
                Button("Default") { sortOrder = .default }
                Button("Alphabetical") { sortOrder = .alphabetical }
                Button("By country") { sortOrder = .byCountry }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("Choose sorting type:")
            }
            
            WelcomeView()
        }
        /// Default setting:
//        .navigationViewStyle(.automatic)
        
        /// The aforementioned extension function:
//        .phoneOnlyStackNavigationView()
        
        .environmentObject(favorites)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

