//
//  ContentView.swift
//  ShoppingList
//
//  Created by Michael Salmon on 2019-09-26.
//  Copyright © 2019 mesme. All rights reserved.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext)
    var managedObjectContext

    @FetchRequest(
        entity: Store.entity(),
        sortDescriptors: []
    )
    var stores: FetchedResults<Store>

    @FetchRequest(
        entity: Product.entity(),
        sortDescriptors: []
    )
    var products: FetchedResults<Product>

    var body: some View {
        NavigationView {
            HStack {
                VStack {
                    StoreAddLink()
                    List(stores, id: \.self) { store in
                        VStack {
                            Text(store.name ?? "")
                            Text(store.branch ?? "")
                        }
                    }
                }
                VStack {
                    ProductAddLink()
                    List(products, id: \.self) { product in
                        Text(product.name)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
