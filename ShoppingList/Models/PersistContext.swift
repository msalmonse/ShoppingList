//
//  PersistContext.swift
//  ShoppingList
//
//  Created by Michael Salmon on 2019-09-27.
//  Copyright © 2019 mesme. All rights reserved.
//

import Foundation
import CoreData
import Combine

extension NSManagedObjectContext {
    func persist() {
        if self.hasChanges {
            do {
                try self.save()
            } catch {
                let nserror = error as NSError
                if nserror.code == 0 && nserror.domain == "Foundation._GenericObjCError" {
                    print("Got invalid error from Objective-C")
                } else {
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        }
    }
}
