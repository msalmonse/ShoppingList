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
                label: { EncapsulatedText("New Category") }
            )
            Text("").hidden()
            .sheet(isPresented: $trigger) {
                CategoryEdit(
                    EditableCategory(),
                    context: self.managedObjectContext
                )
            }
        }
    }
}

struct CategoryRow: View {
    @Environment(\.managedObjectContext)
    var managedObjectContext

    let category: Category

    @State
    var doEdit = false
    @State
    var trigger = false

    func deleteCategory() {
        self.managedObjectContext.delete(self.category)
        self.managedObjectContext.persist()
    }

    var body: some View {
        HStack {
            Button(
                action: { self.trigger = true },
                label: {
                    HStack {
                        VStack(alignment: .leading) {
                            ButtonText(self.category.name ?? "").font(.headline)
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                }
            )

            Text("").hidden()
            .actionSheet(isPresented: $trigger) {
                ActionSheet(
                    title: Text("Category:"),
                    message: Text(self.category.name ?? ""),
                    buttons: [
                        .default(Text("Edit"), action: { self.doEdit = true }),
                        .destructive(Text("Delete"), action: { self.deleteCategory() }),
                        .cancel()
                    ]
                )
            }

            Text("").hidden()
            .sheet(isPresented: $doEdit) {
                CategoryEdit(
                    EditableCategory(self.category),
                    context: self.managedObjectContext
                )
            }
        }
    }
}
