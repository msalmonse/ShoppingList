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

    let cancelDone: String

    init(_ category: EditableCategory, context: NSManagedObjectContext) {
        self.category = category
        self.managedObjectContext = context
        self.cancelDone = category.isEdit ? "Cancel" : "Done"
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
            Spacer()
            InputText(
                "Name",
                text: $category.name,
                onCommit: { self.updateCategory() }
            )
            Spacer()
            HStack {
                Button(
                    action: {
                        self.mode.wrappedValue.dismiss()
                    },
                    label: { EncapsulatedText(cancelDone) }
                )
                .buttonStyle(ShrinkPressed())
                Button(
                    action: { self.updateCategory() },
                    label: { EncapsulatedText(self.category.label) }
                )
                .buttonStyle(ShrinkPressed())
                .disabled(category.name.isEmpty)
            }
        }
        .padding(.horizontal, 20)
    }
}
