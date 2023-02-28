//
//  ResortsView.swift
//  SnowSeeker
//
//  Created by Edwin Przeźwiecki Jr. on 28/02/2023.
//

/// Challenge 3:

import SwiftUI

struct ResortsView: View {
    
    @EnvironmentObject var favorites: Favorites
    
    let resorts: [Resort]
    let resort: Resort
    
    var body: some View {
        HStack {
            Image(resort.country)
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 25)
                .clipShape(
                    RoundedRectangle(cornerRadius: 5)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(.black, lineWidth: 1)
                )
            
            VStack(alignment: .leading) {
                Text(resort.name)
                    .font(.headline)
                
                Text("\(resort.runs) runs")
                    .foregroundColor(.secondary)
            }
            
            if favorites.contains(resort) {
                Spacer()
                
                Image(systemName: "heart.fill")
                    .accessibilityLabel("This is a favorite resort")
                    .foregroundColor(.red)
            }
        }
    }
}

struct ResortsView_Previews: PreviewProvider {
    static var previews: some View {
        ResortsView(resorts: [], resort: Resort.example)
            .environmentObject(Favorites())
    }
}
