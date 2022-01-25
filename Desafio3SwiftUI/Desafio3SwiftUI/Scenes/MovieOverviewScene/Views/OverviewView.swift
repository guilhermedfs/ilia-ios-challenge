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
    @State private var saved: Bool = false
    var path: String {
        return overviewViewModel.overviewData.posterPath ?? ""
    }
    private let transaction: Transaction = .init(animation: .linear)

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .center) {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w342/\(path)"), transaction: transaction) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .transition(.slide)
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(8)
                            .frame(maxWidth: 160, maxHeight: 250)
                    case .failure:
                        Image(systemName: "xmark.icloud.fill")
                    @unknown default:
                        EmptyView()
                    }
                }
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
                                withAnimation(.interpolatingSpring(stiffness: 30, damping: 1), {
                                    saved.toggle()
                                })
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
        .alert("Salvo!", isPresented: $saved) {
            Button("Ok") {
                saved = false
            }
        }
    }
}

//struct OverviewView_Previews: PreviewProvider {
//    static var previews: some View {
//        OverviewView(title: "Hello", overview: "nil", posterPath: "", voteAverage: 0, releaseDate: "", overviewViewModel: <#MovieOverviewViewModel#>)
//    }
//}
