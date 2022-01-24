//
//  NotesView.swift
//  Desafio3SwiftUI
//
//  Created by Guilherme - ília on 20/01/22.
//

import SwiftUI

struct NotesView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(
        entity: FavoritesMovies.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \FavoritesMovies.name, ascending: true)])
    var items: FetchedResults<FavoritesMovies>
    
    var navbarColor = Color(red: 0.071, green: 0.306, blue: 0.471) // #124e78
    @State private var note: String = ""
    @StateObject private var viewModel = NotesViewModel()
    let title: String
    
    var body: some View {
        VStack {
            Section {
                TextEditor(text: $viewModel.model.note)
                    .cornerRadius(20)
                    .padding()
                    .onChange(of: viewModel.model.note) { newValue in
                        viewModel.saveNotes(title: title, note: viewModel.model.note, context: managedObjectContext)
                    }
            }
        }
        .onAppear {
            viewModel.retrieveDataFromCore(title: title)
        }
//        .onDisappear(perform: {
//            viewModel.saveNotes(title: title, note: viewModel.model.note, context: managedObjectContext)
//        })
        .background(Color("background"))
        .navigationTitle("Observation")
    }
}

struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        NotesView(title: "")
    }
}
