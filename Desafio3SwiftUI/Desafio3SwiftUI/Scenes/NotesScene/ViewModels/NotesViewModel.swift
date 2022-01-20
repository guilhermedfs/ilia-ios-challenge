//
//  NotesViewModel.swift
//  Desafio3SwiftUI
//
//  Created by Guilherme - ília on 20/01/22.
//

import Foundation
import CoreData

class NotesViewModel: ObservableObject {
    @Published var model = NotesModel(notes: [])
    
    func saveNotes(title: String, note: String, context: NSManagedObjectContext) {
        let request: NSFetchRequest<FavoritesMovies> = FavoritesMovies.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", title)
        let notation = MoviesNotes(context: context)
        notation.noted = note
        
        do {
            let object = try context.fetch(request)
            if !(object.isEmpty) {
                object.first?.addToNotes(notation)
                model.notes.append(note)
            }
        } catch {
            
        }
      
        PersistenceController.shared.save()
    }
    
    func retrieveDataFromCore(title: String) {
        let notes = PersistenceController.shared.retrieveNotes(title)
        let str = notes.map({String($0)})
        model.notes = str
    }
    
    func deleteNoteFromCore(title: String, note: String, context: NSManagedObjectContext) {
        let request: NSFetchRequest<FavoritesMovies> = FavoritesMovies.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", title)
        let notation = MoviesNotes(context: context)
        notation.noted = note
        
        do {
            let object = try context.fetch(request)
            if !(object.isEmpty) {
                object.first?.removeFromNotes(notation)
                model.notes.append(note)
            }
        } catch {
            
        }
      
        PersistenceController.shared.save()
    }
}
