//
//  ProductsView.swift
//  ShoppingList
//
//  Created by Michael Salmon on 2019-09-27.
//  Copyright © 2019 mesme. All rights reserved.
//

import SwiftUI

struct ProductsView: View {
    @Environment(\.managedObjectContext)
    var managedObjectContext

    @FetchRequest(
        entity: Product.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Product.name, ascending: true)
        ]
    )
    var products: FetchedResults<Product>

    @State
    var trigger: Bool = false

    var body: some View {
        VStack {
            List(products, id: \.self) { product in
                ProductRow(product: product)
            }
            Button(
                action: {
                    self.trigger = true
                },
                label: { Text("New Product") }
            )
            Text("").hidden()
            .sheet(isPresented: $trigger) {
                ProductEdit(EditableProduct(), context: self.managedObjectContext)
            }
        }
    }
}

struct ProductRow: View {
    @Environment(\.managedObjectContext)
    var managedObjectContext

    let product: Product

    var body: some View {
        HStack {
            VStack {
                Text(product.name ?? "").font(.headline)
                Text(product.manufacturer ?? "").font(.subheadline)
            }
            Spacer()
            Button(
                action: {
                    self.managedObjectContext.delete(self.product)
                    self.managedObjectContext.persist()
                },
                label: { Image(systemName: "clear").foregroundColor(.red) }
            )
        }
    }
}

struct ProductsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsView()
    }
}
