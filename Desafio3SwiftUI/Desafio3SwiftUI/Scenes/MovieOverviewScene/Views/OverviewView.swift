//
//  OverviewView.swift
//  Desafio3_SwiftUI
//
//  Created by Guilherme - ília on 27/12/21.
//

import SwiftUI
import ImageGetter

struct OverviewView: View {
    let title: String
    let overview: String
    let posterPath: String?
    let voteAverage: Double
    let releaseDate: String
    var overviewViewModel = MovieOverviewViewModel()
    @Environment(\.managedObjectContext) var managedObjectContext

    @FetchRequest(
        entity: FavoritesMovies.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \FavoritesMovies.imagePath, ascending: false)])
    var items: FetchedResults<FavoritesMovies>

    var path: String {
        return posterPath ?? ""
    }
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .center) {
                ImageGetter(path: posterPath)
                Text(title)
                    .font(.title2.bold())
                    .padding(20)
                Text(overview)
                    .font(.system(size: 22))
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            }
            Spacer()
            Section {
                Text("Release date: ")
                    .fontWeight(.bold) +
                Text("\(releaseDate)")
                Text("Vote average: ")
                    .fontWeight(.bold) +
                Text("\(String(format: "%.1f", voteAverage))")
                    .foregroundColor(overviewViewModel.getTextColor(average: voteAverage))
            }
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                let isSaved = overviewViewModel.isSaved(items: items, title: title)
                HStack {
                    if isSaved {
                        NavigationLink(destination: NotesView(title: title)) {
                            Image(systemName: "note.text")
                                .foregroundColor(.yellow)
                        }
                    }
                    Button {
                        let save = FavoritesMovies(context: managedObjectContext)
                        if isSaved {
                            PersistenceController.shared.delete(title)
                            save.objectWillChange.send()
                        } else {
                            save.name = title
                            save.resume = overview
                            save.imagePath = posterPath
                            save.releaseDate = releaseDate
                            save.voteAverage = voteAverage
                            let movieNoteTest = MoviesNotes(context: managedObjectContext)
                            movieNoteTest.noted = "Testing"
                            save.addToNotes(movieNoteTest)
                            let movieNoteTest2 = MoviesNotes(context: managedObjectContext)
                            movieNoteTest2.noted = "Testing 2"
                            save.addToNotes(movieNoteTest2)
                            PersistenceController.shared.save()
                            save.objectWillChange.send()
                        }
                    } label: {
                        if isSaved {
                            Image(systemName: "trash.fill")
                        } else {
                            Image(systemName: "square.and.arrow.down.fill")
                        }
                    }
                    .foregroundColor(.red)
                }
            }
        }
    }
}

struct OverviewView_Previews: PreviewProvider {
    static var previews: some View {
        OverviewView(title: "Hello", overview: "nil", posterPath: "", voteAverage: 0, releaseDate: "")
    }
}
