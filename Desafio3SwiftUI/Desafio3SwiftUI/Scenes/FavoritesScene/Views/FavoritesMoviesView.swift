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
        sortDescriptors: [NSSortDescriptor(keyPath: \FavoritesMovies.name, ascending: true)], predicate: NSPredicate(format: "name != %@", ""))
    var items: FetchedResults<FavoritesMovies>
    
    @State private var reload: Bool = false
    
    var columns: [GridItem] = [
        GridItem(.adaptive(minimum: 120)),
        GridItem(.adaptive(minimum: 120)),
    ]
    
    let height: CGFloat = 250
    
    var body: some View {
        NavigationView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(0..<items.count, id: \.self) { count in
                    withAnimation {
                        NavigationLink(destination: OverviewView(title: items[count].name ?? "", overview: items[count].resume ?? "", posterPath: items[count].imagePath ?? "", voteAverage: items[count].voteAverage , releaseDate: items[count].releaseDate ?? ""), label: {
                            CardView(title: items[count].name ?? "", posterPath: items[count].imagePath ?? "")
                                .frame(height: height)
                        })
                    }
                }
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
