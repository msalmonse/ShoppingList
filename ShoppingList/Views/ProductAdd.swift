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

    @State
    var name = ""

    var body: some View {
        VStack {
            TextField("Product name", text: $name)
            Button(
                action: {
                    let product = Product(context: self.managedObjectContext)
                    product.id = UUID()
                    product.name = self.name
                },
                label: { Text("Add")})
        }

    }
}


struct ProductAdd_Previews: PreviewProvider {
    static var previews: some View {
        ProductAdd()
    }
}
