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
                        ForEach(movies.movies.indices, id: \.self) { movieIndex in
                            let mv = movies.movies[movieIndex]
                            NavigationLink(destination:  OverviewView(title: mv.title!, overview: mv.overview!, posterPath: mv.posterPath, voteAverage: mv.voteAverage!, releaseDate:   overviewViewModel.formatDate(date: mv.releaseDate!))) {
                            CardView(title: mv.title!, posterPath: mv.posterPath)
                                .frame(height: height)
                                .onAppear {
                                    if movieIndex == movies.movies.count - 2 {
                                        movies.movieData.currentPage += 1
                                        movies.fetchData()
                                    }
                                }
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
