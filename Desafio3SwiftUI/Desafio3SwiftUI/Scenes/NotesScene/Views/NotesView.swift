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
    @State private var isEnabled: Bool = false
    @StateObject private var viewModel = NotesViewModel()
    @State var animate = 0.0
    let title: String
    
    var body: some View {
        VStack {
            if isEnabled {
                TextField("Type your note", text: $note.animation())
                        .padding([.leading,.trailing], 30)
                        .padding(.top, 10)
                        .padding()
                        .textFieldStyle(.roundedBorder)
                        .background(navbarColor)
                        .onSubmit {
                            viewModel.saveNotes(title: title, note: note, context: managedObjectContext)
                        }
            }
            List {
                ForEach(viewModel.model.notes, id: \.self) { note in
                    HStack {
                            Text(note)
                                .padding(.top)
                        Spacer()
                        Button {
                        } label: {
                            Image(systemName: "minus.circle.fill")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .buttonStyle(PlainButtonStyle())
        }
        .toolbar {
            Button {
                withAnimation(.spring(), {
                    isEnabled.toggle()
                })
            } label: {
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(.green)
            }
        }
        .onAppear {
            DispatchQueue.main.async {
                viewModel.retrieveDataFromCore(title: title)
            }
        }
        .navigationTitle("Note")
    }
}

struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        NotesView(title: "")
    }
}
