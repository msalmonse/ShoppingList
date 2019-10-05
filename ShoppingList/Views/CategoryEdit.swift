//
//  CategoryEdit.swift
//  ShoppingList
//
//  Created by Michael Salmon on 2019-09-30.
//  Copyright © 2019 mesme. All rights reserved.
//

import CoreData
import SwiftUI

struct CategoryEdit: View {
    @Environment(\.presentationMode)
    var mode: Binding<PresentationMode>

    @ObservedObject
    var category: EditableCategory
    var managedObjectContext: NSManagedObjectContext

    init(_ category: EditableCategory, context: NSManagedObjectContext) {
        self.category = category
        self.managedObjectContext = context
    }

    func updateCategory() {
        if category.isEdit {
            category.update()
        } else {
            category.add(context: managedObjectContext)
        }
        managedObjectContext.persist()
        if category.isEdit { mode.wrappedValue.dismiss() }
    }

    var body: some View {
        VStack {
            TextField(
                "Category name",
                text: $category.name,
                onCommit: { self.updateCategory() }
            )
            Button(
                action: { self.updateCategory() },
                label: { Text(self.category.label) }
            )
            .disabled(category.name.isEmpty)
        }
        .padding(.horizontal, 20)
    }
}
