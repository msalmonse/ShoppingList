//
//  PersistContext.swift
//  ShoppingList
//
//  Created by Michael Salmon on 2019-09-27.
//  Copyright © 2019 mesme. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObjectContext {
    func persist() {
        if self.hasChanges {
            do {
                try self.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
