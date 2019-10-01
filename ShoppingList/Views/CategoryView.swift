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

    @State
    var trigger: Bool = false

    var body: some View {
        VStack {
            List(categories, id: \.self) { category in
                CategoryRow(category: category)
            }
            Button(
                action: {
                    self.trigger = true
                },
                label: { Text("New Category") }
            )
            Text("").hidden()
            .sheet(isPresented: $trigger) { CategoryEdit(EditableCategory()) }
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

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
    }
}
