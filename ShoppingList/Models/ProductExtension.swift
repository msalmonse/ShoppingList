//
//  ProductExtension.swift
//  ShoppingList
//
//  Created by Michael Salmon on 2019-09-28.
//  Copyright © 2019 mesme. All rights reserved.
//

import Foundation

extension Product {
    var title: String {
        if manufacturer == nil {
            return name!
        } else {
            return "\(manufacturer!) \(name!)"
        }
    }
}
