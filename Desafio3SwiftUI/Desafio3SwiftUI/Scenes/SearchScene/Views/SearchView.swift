//
//  SearchView.swift
//  Desafio3SwiftUI
//
//  Created by Guilherme - ília on 05/01/22.
//

import SwiftUI

struct SearchView: View {
    @State var movieField: String = ""
    @ObservedObject var movies = MoviesViewModel()

    var columns: [GridItem] = [
        GridItem(.adaptive(minimum: 120)),
        GridItem(.adaptive(minimum: 120)),
    ]
    let height: CGFloat = 250
    
    
    var body: some View {
        ZStack {
            TextField("Type the movie name", text: $movieField, onCommit: textCommited)
                .padding()
                .textFieldStyle(.roundedBorder)
            Spacer()
        }
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(movies.searchResult.indices, id: \.self) { movieIndex in
                    let mv = movies.searchResult[movieIndex]
                    NavigationLink(destination:  OverviewView(overviewViewModel: MovieOverviewViewModel(overviewData: OverviewData(title: mv.title , overview: mv.overview , posterPath: mv.posterPath ?? "", voteAverage: mv.voteAverage , releaseDate: mv.releaseDate )))) {
                        CardView(title: mv.title, posterPath: mv.posterPath)
                            .frame(height: height)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding()
            
        }
    }
    
    func textCommited() {
        DispatchQueue.main.async {
            movies.fetchData(queryType: .searchMovies, title: movieField)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
