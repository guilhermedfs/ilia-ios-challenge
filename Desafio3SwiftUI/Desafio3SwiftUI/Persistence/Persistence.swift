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
    
    func addNote(_ title: String, completion: @escaping (Error?) -> () = {_ in}) {

    }
    
    func retrieveNotes(_ title: String, completion: @escaping (Error?) -> () = {_ in}) -> [String] {
        let request: NSFetchRequest<FavoritesMovies> = FavoritesMovies.fetchRequest()
        request.predicate = NSPredicate(format: "name CONTAINS[cd] %@", title)
        var strings: [String] = []
        let context = container.viewContext
        do {
            let objects = try context.fetch(request)
            let notes = objects.first?.notes as? Set<MoviesNotes>
            
            for note in notes! {
                strings.append(note.noted!)
            }
            
            return strings
            
        } catch {
            print("error: \(error.localizedDescription)")
        }
        
        return strings
    }
    
}
