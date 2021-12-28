//
//  ContentView.swift
//  Desafio3_SwiftUI
//
//  Created by Guilherme - ília on 27/12/21.
//

import SwiftUI

struct ContentView: View {
    // 1. Number of items will be display in row
    var columns: [GridItem] = [
        GridItem(.adaptive(minimum: 120)),
        GridItem(.adaptive(minimum: 120)),
    ]
    // 2. Fixed height of card
    let height: CGFloat = 250
    // 3. Get mock cards data
    @ObservedObject var movies = MoviesViewModel()
    @ObservedObject var overviewViewModel = MovieOverviewViewModel()
        
    var body: some View {
        NavigationView {
                ScrollView {
                    // 4. Populate into grid
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(movies.movies, id: \.posterPath) { title in
                            NavigationLink(destination:   OverviewView(title: title.title!, overview: title.overview!, posterPath: title.posterPath, voteAverage: title.voteAverage!, releaseDate:   overviewViewModel.formatDate(date: title.releaseDate!))) {
                            CardView(title: title.title!, posterPath: title.posterPath)
                                .frame(height: height)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding()
                }
                .onAppear {
                    self.movies.fetchData()
                }
                .navigationTitle("Movies")
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
