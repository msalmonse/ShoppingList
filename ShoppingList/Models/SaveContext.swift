//
//  SaveContext.swift
//  ShoppingList
//
//  Created by Michael Salmon on 2019-09-27.
//  Copyright © 2019 mesme. All rights reserved.
//

import Foundation
import UIKit

func saveContext() {
    if let app = (UIApplication.shared.delegate as? AppDelegate) {
        app.saveContext()
    }
}
