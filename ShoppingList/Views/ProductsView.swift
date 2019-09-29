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

    var body: some View {
        VStack {
            ProductAdd()
            List(products, id: \.self) { product in
                ProductRow(product: product)
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

struct ProductAdd: View {
    @Environment(\.managedObjectContext)
    var managedObjectContext

    @FetchRequest(
        entity: Category.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Category.name, ascending: true)
        ]
    )
    var categories: FetchedResults<Category>

    @State
    var categoryIndex = -1
    @State
    var name = ""
    @State
    var manufacturer = ""

    var body: some View {
        VStack {
            TextField("Product name", text: $name)
            TextField("Product manufacturer", text: $manufacturer)
            CategorySelector(index: $categoryIndex, categories: categories)
            Button(
                action: {
                    let product = Product(context: self.managedObjectContext)
                    if self.categories.indices.contains(self.categoryIndex) {
                        let category = self.categories[self.categoryIndex]
                        product.category = category
                        category.addToProducts(product)
                    }
                    product.id = UUID()
                    product.name = self.name
                    product.manufacturer = self.manufacturer
                    self.managedObjectContext.persist()
                    // Clean up for next time
                    self.name = ""
                    self.manufacturer = ""
                },
                label: { Text("Add") }
            )
            .disabled(name.isEmpty)
        }
        .padding(.horizontal, 20)
    }
}
struct ProductsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsView()
    }
}
