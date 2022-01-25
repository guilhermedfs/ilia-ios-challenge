//
//  FavoritesMoviesView.swift
//  Desafio3SwiftUI
//
//  Created by Guilherme - ília on 19/01/22.
//

import SwiftUI

struct FavoritesMoviesView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext

    @FetchRequest(
        entity: FavoritesMovies.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \FavoritesMovies.name, ascending: true)],
        predicate: NSPredicate(format: "name != nil"))
    var items: FetchedResults<FavoritesMovies>
    
    @State private var reload: Bool = false
    
    var columns: [GridItem] = [
        GridItem(.adaptive(minimum: 120)),
        GridItem(.adaptive(minimum: 120)),
    ]
    
    let height: CGFloat = 250
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(items) { item in
                            NavigationLink(destination: OverviewView(overviewViewModel: MovieOverviewViewModel(overviewData: OverviewData(title: item.name ?? "", overview: item.resume ?? "", posterPath: item.imagePath, voteAverage: item.voteAverage, releaseDate: item.releaseDate ?? ""))), label: {
                                CardView(title: item.name ?? "", posterPath: item.imagePath ?? "")
                                    .foregroundColor(.black)
                            })
                    }
                }
                .padding(.top, 18)
            }
            .navigationTitle("Movies")
        }
        .onAppear {
            reload.toggle()
        }
    }
}

//struct FavoritesMoviesView_Previews: PreviewProvider {
//    static var previews: some View {
//        FavoritesMoviesView(reload: true)
//    }
//}
