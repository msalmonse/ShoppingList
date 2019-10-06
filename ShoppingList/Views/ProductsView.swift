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
        entity: Category.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Category.name, ascending: true)
        ]
    )
    var categories: FetchedResults<Category>

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
                ProductRow(product: product, categories: self.categories)
            }
            Button(
                action: {
                    self.trigger = true
                },
                label: { Text("New Product") }
            )
            Text("").hidden()
            .sheet(isPresented: $trigger) {
                ProductEdit(
                    EditableProduct(),
                    context: self.managedObjectContext,
                    categories: self.categories
                )
            }
        }
    }
}

struct ProductRow: View {
    @Environment(\.managedObjectContext)
    var managedObjectContext

    let product: Product
    let categories: FetchedResults<Category>

    @State
    var doEdit = false
    @State
    var categoryIndex = -1
    @State
    var trigger = false

    func deleteProduct() {
        self.managedObjectContext.delete(self.product)
        self.managedObjectContext.persist()
    }

    func editProduct() {
        categoryIndex = product.category == nil
            ? -1 : (categories.firstIndex(of: product.category!) ?? -1)
        doEdit = true
    }

    var body: some View {
        HStack {
            Button(
                action: { self.trigger = true },
                label: {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(product.name ?? "").font(.headline)
                            Text(product.manufacturer ?? "").font(.subheadline)
                        }
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text(product.category?.name ?? "")
                        }
                        Image(systemName: "chevron.right")
                    }
                }
            )

            Text("").hidden()
            .actionSheet(isPresented: $trigger) {
                ActionSheet(
                    title: Text("Product:"),
                    message: Text(self.product.title),
                    buttons: [
                        .default(Text("Edit"), action: { self.editProduct() }),
                        .destructive(Text("Delete"), action: { self.deleteProduct() }),
                        .cancel()
                    ]
                )
            }

            Text("").hidden()
            .sheet(isPresented: $doEdit) {
                ProductEdit(
                    EditableProduct(self.product, categoryIndex: self.categoryIndex),
                    context: self.managedObjectContext,
                    categories: self.categories
                )
            }
        }
    }
}
