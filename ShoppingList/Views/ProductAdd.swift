//
//  ProductAdd.swift
//  ShoppingList
//
//  Created by Michael Salmon on 2019-09-27.
//  Copyright © 2019 mesme. All rights reserved.
//

import SwiftUI

struct ProductAddLink: View {
    var body: some View {
        NavigationLink(
            destination: ProductAdd(),
            label: { Text("Add Product") }
        )
    }
}

struct ProductAdd: View {
    @Environment(\.managedObjectContext)
    var managedObjectContext
    @Environment(\.presentationMode)
    var mode: Binding<PresentationMode>

    @State
    var name = ""
    @State
    var manufacturer = ""

    var body: some View {
        VStack {
            TextField("Product name", text: $name)
            TextField("Product manufacturer", text: $manufacturer)
            Button(
                action: {
                    let product = Product(context: self.managedObjectContext)
                    product.id = UUID()
                    product.name = self.name
                    product.manufacturer = self.manufacturer
                    self.managedObjectContext.persist()
                    // Clean up for next time
                    self.name = ""
                    self.manufacturer = ""
                    self.mode.wrappedValue.dismiss()
                },
                label: { Text("Add") }
            )
            .disabled(name.isEmpty)
        }
        .padding(.horizontal, 20)
    }
}

struct ProductAdd_Previews: PreviewProvider {
    static var previews: some View {
        ProductAdd()
    }
}
