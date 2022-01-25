//
//  InitialView.swift
//  Desafio3SwiftUI
//
//  Created by Guilherme - ília on 19/01/22.
//

import SwiftUI

struct InitialView: View {
    @State private var selected = 0
    @State private var movieSelec: Bool = false
    var body: some View {
        
        ZStack {
            TabView(selection: $selected) {
                ContentView()
                    .tabItem {
                        Button {
                            withAnimation {
                                selected = 0
                            }
                        } label: {
                            Label("Movies", systemImage: "tv.fill")
                        }
                    }
                    .tag(0)

                FavoritesMoviesView()
                    .tabItem {
                        Button {
                            withAnimation {
                                selected = 0
                            }
                        } label: {
                            Label("Favorites", systemImage: "star.fill")
                        }
                    }
                    .tag(1)
            }
        }
    }
}

struct InitialView_Previews: PreviewProvider {
    static var previews: some View {
        InitialView()
    }
}
