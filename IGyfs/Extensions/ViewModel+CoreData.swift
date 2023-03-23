//
//  ViewController+CoreData.swift
//  IGyfs
//
//  Created by Rafael Veronez Dias on 16/03/23.
//

import UIKit
import CoreData


extension ShowGiffViewModel {
    var contextNS: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
         
        return appDelegate.persistentContainer.viewContext
    }
}

extension FavoriteGiffViewModel {
    var contextNS: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
         
        return appDelegate.persistentContainer.viewContext
    }
}
