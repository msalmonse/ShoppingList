//
//  StoreSelector.swift
//  ShoppingList
//
//  Created by Michael Salmon on 2019-09-28.
//  Copyright © 2019 mesme. All rights reserved.
//

import SwiftUI

struct StoreSelector: View {
    @Binding
    var index: Int
    let stores: FetchedResults<Store>

    var body: some View {
        Picker(selection: $index, label: Text("Store")) {
            Text("Any").tag(-1)
            ForEach(stores.indices, id: \.self) { index in
                Text(self.stores[index].name ?? "").tag(index)
            }
        }
    }
}
