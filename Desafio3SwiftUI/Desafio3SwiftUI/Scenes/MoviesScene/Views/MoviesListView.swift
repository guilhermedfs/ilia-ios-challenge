//
//  MoviesListView.swift
//  Desafio3SwiftUI
//
//  Created by Guilherme - ília on 05/01/22.
//

import SwiftUI

struct MoviesListView: View {
    var columns: [GridItem] = [
        GridItem(.adaptive(minimum: 120)),
        GridItem(.adaptive(minimum: 120)),
    ]
    
    let height: CGFloat = 250
    
    let movies: MoviesViewModel
    let queryType: QueryTypes
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(movies.movies.indices, id: \.self) { movieIndex in
                let mv = movies.movies[movieIndex]
                NavigationLink(destination:  OverviewView(overviewViewModel: MovieOverviewViewModel(overviewData: OverviewData(title: mv.title ?? "", overview: mv.overview ?? "", posterPath: mv.posterPath, voteAverage: mv.voteAverage ?? 0.0, releaseDate: mv.releaseDate ?? "")))) {
                    CardView(title: mv.title!, posterPath: mv.posterPath)
                        .frame(height: height)
                        .onAppear {
                            if movieIndex == movies.movies.count - 2 {
                                movies.movieData.currentPage += 1
                                movies.fetchData(queryType: queryType, title: nil)
                            }
                        }
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding()
    }
}


//struct MoviesListView_Previews: PreviewProvider {
//    static var previews: some View {
//        // MoviesListView()
//    }
//}
