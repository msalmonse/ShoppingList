//
//  CategoryView.swift
//  ShoppingList
//
//  Created by Michael Salmon on 2019-09-29.
//  Copyright © 2019 mesme. All rights reserved.
//

import Foundation
import SwiftUI

struct CategoriesView: View {
    @Environment(\.managedObjectContext)
    var managedObjectContext

    @FetchRequest(
        entity: Category.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Category.name, ascending: true)
        ]
    )
    var categories: FetchedResults<Category>

    var body: some View {
        VStack {
            CategoryAdd()
            List(categories, id: \.self) { category in
                CategoryRow(category: category)
            }
        }
    }
}

struct CategoryRow: View {
    @Environment(\.managedObjectContext)
    var managedObjectContext

    let category: Category

    var body: some View {
        HStack {
            VStack {
                Text(category.name ?? "").font(.headline)
            }
            Spacer()
            Button(
                action: {
                    self.managedObjectContext.delete(self.category)
                    self.managedObjectContext.persist()
                },
                label: { Image(systemName: "clear").foregroundColor(.red) }
            )
        }
    }
}

struct CategoryAdd: View {
    @Environment(\.managedObjectContext)
    var managedObjectContext

    @State
    var name = ""

    var body: some View {
        VStack {
            TextField("Category name", text: $name)
            Button(
                action: {
                    let category = Category(context: self.managedObjectContext)
                    category.id = UUID()
                    category.name = self.name
                    self.managedObjectContext.persist()
                    // clean up for next time
                    self.name = ""
                },
                label: { Text("Add")}
            )
            .disabled(name.isEmpty)
        }
        .padding(.horizontal, 20)
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
    }
}
