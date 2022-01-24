import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "Model")
        
        container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func save(completion: @escaping (Error?) -> () = {_ in}) {
        let context = container.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
                completion(nil)
            } catch {
                completion(error)
                print(error.localizedDescription)
            }
        }
    }
    
    func delete(_ object: NSManagedObject, completion: @escaping (Error?) -> () = {_ in}) {
        let context = container.viewContext
        context.delete(object)
        save(completion: completion)
    }
    
    func delete(_ title: String, completion: @escaping (Error?) -> () = {_ in}) {
        let request: NSFetchRequest<FavoritesMovies> = FavoritesMovies.fetchRequest()
        request.predicate = NSPredicate(format: "name CONTAINS[cd] %@", title)
        
        let context = container.viewContext
        
        do {
            let objects = try context.fetch(request)
            
            for object in objects {
                context.delete(object)
            }
            
            try context.save()
            
        } catch {
            print("error: \(error.localizedDescription)")
        }
     
    }

    func retrieveNotes(_ title: String, completion: @escaping (Error?) -> () = {_ in}) -> String {
        let request: NSFetchRequest<MoviesNotes> = MoviesNotes.fetchRequest()
        request.predicate = NSPredicate(format: "movieTitle == %@", title)
        let context = container.viewContext
        var note = ""
        do {
            let objects = try context.fetch(request)
            guard let notes = objects.first?.noted else {return ""}
            note = notes
            return note
            
        } catch {
            print("error: \(error.localizedDescription)")
        }
        
        return note
    }
    
}
