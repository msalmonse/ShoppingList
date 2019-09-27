//
//  StoresView.swift
//  ShoppingList
//
//  Created by Michael Salmon on 2019-09-27.
//  Copyright © 2019 mesme. All rights reserved.
//

import SwiftUI

struct StoresView: View {
    @Environment(\.managedObjectContext)
    var managedObjectContext

    @FetchRequest(
        entity: Store.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Store.name, ascending: true)
        ]
    )
    var stores: FetchedResults<Store>

    var body: some View {
        VStack {
            StoreAddLink()
            List(stores, id: \.self) { store in
                VStack {
                    Text(store.name ?? "")
                    Text(store.branch ?? "")
                }
            }
        }
    }
}

struct StoresView_Previews: PreviewProvider {
    static var previews: some View {
        StoresView()
    }
}
