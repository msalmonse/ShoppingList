//
//  SetExtension.swift
//  ShoppingList
//
//  Created by Michael Salmon on 2019-10-02.
//  Copyright © 2019 mesme. All rights reserved.
//

import Foundation

extension Set {
    subscript(member: Element) -> Bool {
        get { contains(member) }
        set {
            if newValue {
                insert(member)
            } else {
                remove(member)
            }
        }
    }
}
