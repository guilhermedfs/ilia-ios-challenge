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
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .center) {
                ImageGetter(path: path)
                    .padding(.top, 10)
                Text(overviewViewModel.overviewData.title)
                    .font(.title2.bold())
                    .padding(20)
                ScrollView {
                    Text(overviewViewModel.overviewData.overview)
                        .font(.body)
                        .padding(.horizontal)
                }
            }
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 0) {
                Text("Release date: ")
                    .fontWeight(.bold) +
                Text("\(overviewViewModel.formatDate(date: overviewViewModel.overviewData.releaseDate))")
                Text("Vote average: ")
                    .fontWeight(.bold) +
                Text("\(String(format: "%.1f", overviewViewModel.overviewData.voteAverage))")
                    .foregroundColor(overviewViewModel.getTextColor(average: overviewViewModel.overviewData.voteAverage))
            }
            .padding(.leading)
            .padding(.bottom)
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
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

//struct OverviewView_Previews: PreviewProvider {
//    static var previews: some View {
//        OverviewView(title: "Hello", overview: "nil", posterPath: "", voteAverage: 0, releaseDate: "", overviewViewModel: <#MovieOverviewViewModel#>)
//    }
//}
