//
//  PersistenceManager.swift
//  04_TodoTDD
//
//  Created by rae on 2021/11/24.
//

import Foundation
import CoreData

class PersistenceManager {
    static var shared: PersistenceManager = PersistenceManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }
    
    func fetch<T: NSManagedObject>(request: NSFetchRequest<T>) -> [T] {
        do {
            let fetchResult = try self.context.fetch(request)
            return fetchResult
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func insertTodo(todo: Todo) -> Bool {
        let entity = NSEntityDescription.entity(forEntityName: "TodoEntity", in: self.context)
        
        if let entity = entity {
            let managedObject = NSManagedObject(entity: entity, insertInto: self.context)
            
            managedObject.setValue(todo.title, forKey: "title")
            managedObject.setValue(todo.address, forKey: "address")
            managedObject.setValue(todo.desc, forKey: "desc")
            
            do {
                try self.context.save()
                return true
            } catch {
                print(error.localizedDescription)
                return false
            }
        } else {
            return false
        }
    }
    
    func remove(object: NSManagedObject) -> Bool {
        self.context.delete(object)
        do {
            try context.save()
            return true
        } catch {
            return false
        }
    }
    
    func removeAll<T: NSManagedObject>(request: NSFetchRequest<T>) -> Bool {
        let request: NSFetchRequest<NSFetchRequestResult> = T.fetchRequest()
        let remove = NSBatchDeleteRequest(fetchRequest: request)
        do {
            try self.context.execute(remove)
            return true
        } catch {
            return false
        }
    }
}
