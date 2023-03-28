//
//  GiffDatabase.swift
//  IGyfs
//
//  Created by Rafael Veronez Dias on 16/03/23.
//

import Foundation
import CoreData

class GiffDatabase: NSObject {
    static let shared: GiffDatabase = GiffDatabase()
    private var fetchResultController: NSFetchedResultsController<FavoriteGiff>?
    
    private override init() {}
    
    public func getFavoriteGiffById(context: NSManagedObjectContext, id: String) -> [FavoriteGiff?] {
        let fetchRequest: NSFetchRequest<FavoriteGiff> = FavoriteGiff.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.predicate = NSPredicate(format: "giff_id == %@", id)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try fetchResultController?.performFetch()
            return fetchResultController?.fetchedObjects ?? []
        } catch {
            print("Erro ao pegar giff por id \(error)")
            return []
        }
    }
    
    public func getFavoriteGiffs(context: NSManagedObjectContext) -> [FavoriteGiff?] {
        let fetchRequest: NSFetchRequest<FavoriteGiff> = FavoriteGiff.fetchRequest()
        
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultController?.delegate = self
        do {
            try fetchResultController?.performFetch()
            return fetchResultController?.fetchedObjects ?? []

        } catch {
            print("Erro ao pegar items \(error)")
            return []
        }
    }
    
    public func saveFavoriteGiff(giff: Giff, context: NSManagedObjectContext) {
        let favGiff: FavoriteGiff = FavoriteGiff(context: context)
        
        favGiff.title = giff.title
        favGiff.giff_id = giff.id
        favGiff.url = giff.url
        favGiff.giff_image = giff.mediaUrl
        
        do {
            try context.save()
        } catch {
            print("Erro ao tentar salvar giff \(error.localizedDescription)")
        }
    }
    
    public func removeGiffFromFavorite(id: String, context: NSManagedObjectContext, isSuccess: @escaping(Bool, Error?) -> Void) {
        let fetchRequest: NSFetchRequest<FavoriteGiff> = FavoriteGiff.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "giff_id == %@", id)
        do {
            let favGiff = try context.fetch(fetchRequest).first
            
            if let favGiff = favGiff {
                context.delete(favGiff)
                try context.save()
                isSuccess(true, nil)
            }
            
        } catch {
            print("Erro ao deletar item! \(error)")
            isSuccess(false, error)
        }
    }
    
}

extension GiffDatabase: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .delete:
            break
        case .insert:
            print("New items!")
            break
        default:
            print("New changes")
        }
    }
}
