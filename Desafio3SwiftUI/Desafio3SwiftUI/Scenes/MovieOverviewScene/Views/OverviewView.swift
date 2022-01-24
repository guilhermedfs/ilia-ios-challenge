//
//  OverviewView.swift
//  Desafio3_SwiftUI
//
//  Created by Guilherme - ília on 27/12/21.
//

import SwiftUI
import ImageGetter

struct OverviewView: View {
    var overviewViewModel: MovieOverviewViewModel
    @Environment(\.managedObjectContext) var managedObjectContext

    @FetchRequest(
        entity: FavoritesMovies.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \FavoritesMovies.imagePath, ascending: false)])
    var items: FetchedResults<FavoritesMovies>

    var path: String {
        return overviewViewModel.overviewData.posterPath ?? ""
    }
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .center) {
                ImageGetter(path: path)
                Text(overviewViewModel.overviewData.title)
                    .font(.title2.bold())
                    .padding(20)
                Text(overviewViewModel.overviewData.overview)
                    .font(.system(size: 22))
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            }
            Spacer()
            Section {
                Text("Release date: ")
                    .fontWeight(.bold) +
                Text("\(overviewViewModel.overviewData.releaseDate)")
                Text("Vote average: ")
                    .fontWeight(.bold) +
                Text("\(String(format: "%.1f", overviewViewModel.overviewData.voteAverage))")
                    .foregroundColor(overviewViewModel.getTextColor(average: overviewViewModel.overviewData.voteAverage))
            }
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                let isSaved = overviewViewModel.isSaved(items: items, title: overviewViewModel.overviewData.title)
                HStack {
                    if isSaved {
                        NavigationLink(destination: NotesView(title: overviewViewModel.overviewData.title)) {
                            Image(systemName: "note.text")
                                .foregroundColor(.yellow)
                        }
                    }
                    Button {
                        if isSaved {
                            overviewViewModel.unfavoriteMovie(context: managedObjectContext)
                        } else {
                            overviewViewModel.favoriteMovie(context: managedObjectContext)
                        }
                    } label: {
                        if isSaved {
                            Image(systemName: "star.fill")
                        } else {
                            Image(systemName: "star")
                        }
                    }
                    .foregroundColor(.red)
                }
            }
        }
    }
}

//struct OverviewView_Previews: PreviewProvider {
//    static var previews: some View {
//        OverviewView(title: "Hello", overview: "nil", posterPath: "", voteAverage: 0, releaseDate: "", overviewViewModel: <#MovieOverviewViewModel#>)
//    }
//}
