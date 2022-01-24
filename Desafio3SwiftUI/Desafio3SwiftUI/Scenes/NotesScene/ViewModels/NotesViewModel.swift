//
//  NotesViewModel.swift
//  Desafio3SwiftUI
//
//  Created by Guilherme - ília on 20/01/22.
//

import Foundation
import CoreData

class NotesViewModel: ObservableObject {
    @Published var model = NotesModel(note: "")
    
    func saveNotes(title: String, note: String, context: NSManagedObjectContext) {
        let request: NSFetchRequest<MoviesNotes> = MoviesNotes.fetchRequest()
        request.predicate = NSPredicate(format: "movieTitle == %@", title)
        
        do {
            let object = try context.fetch(request)
            if !(object.isEmpty) {
                object.first?.noted = note
                model.note = note
            }
        } catch {
            
        }
        
        PersistenceController.shared.save()
    }
    
    func retrieveDataFromCore(title: String) {
        let notes = PersistenceController.shared.retrieveNotes(title)
        model.note = notes
    }

}
