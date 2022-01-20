//
//  InitialView.swift
//  Desafio3SwiftUI
//
//  Created by Guilherme - ília on 19/01/22.
//

import SwiftUI

struct InitialView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Movies", systemImage: "tv.fill")
                }
            FavoritesMoviesView()
                .tabItem {
                    Label("Favorites", systemImage: "star.fill")
                }
        }
    }
}

struct InitialView_Previews: PreviewProvider {
    static var previews: some View {
        InitialView()
    }
}
