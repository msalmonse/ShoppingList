//
//  ProductSelector.swift
//  ShoppingList
//
//  Created by Michael Salmon on 2019-10-05.
//  Copyright © 2019 mesme. All rights reserved.
//

import SwiftUI

struct ProductSelector: View {
    @Binding
    var index: Int
    let products: FetchedResults<Product>

    var body: some View {
        VStack {
            Picker(selection: $index, label: Text("")) {
                ForEach(products.indices, id: \.self) { index in
                    Text(self.products[index].name ?? "").tag(index)
                }
            }
            Text("Product").bold()
        }
    }
}
