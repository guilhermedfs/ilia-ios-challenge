//
//  ContentView.swift
//  Desafio3_SwiftUI
//
//  Created by Guilherme - ília on 27/12/21.
//

import SwiftUI
import NavBarAppearance

var navbarColor = Color(red: 0.071, green: 0.306, blue: 0.471) // #124e78
var titleColor = Color(red: 0.851, green: 0.016, blue: 0.161) // #d90429

struct ContentView: View {
    // 1. Number of items will be display in row
    
    // 2. Fixed height of card
    
    // 3. Get mock cards data
    @ObservedObject var movies = MoviesViewModel()
    @State var isPopoverPresented = false
    @State var isSearchPressed: Int? = nil
    
    var body: some View {
        NavigationView {
            ScrollView {
                // 4. Populate into grid
                MoviesListView(movies: movies, queryType: .upcomingMovies)
            }
            .onAppear {
                self.movies.fetchData(queryType: .upcomingMovies, title: nil)
            }
            .navigationTitle("Movies")
            .toolbar {
                NavigationLink(destination: SearchView(), tag: 1, selection: $isSearchPressed) {
                    Button {
                        self.isSearchPressed = 1
                    } label: {
                        Image(systemName: "magnifyingglass")
                    }
                }
            }
            .navigationBarColor(backgroundColor: UIColor(navbarColor), tintColor: UIColor(titleColor))
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
