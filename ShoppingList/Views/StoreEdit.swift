//
//  StoreEdit.swift
//  ShoppingList
//
//  Created by Michael Salmon on 2019-09-30.
//  Copyright © 2019 mesme. All rights reserved.
//

import CoreData
import SwiftUI

struct StoreEdit: View {
    @Environment(\.presentationMode)
    var mode: Binding<PresentationMode>

    @ObservedObject
    var store: EditableStore
    var managedObjectContext: NSManagedObjectContext
    var categories: FetchedResults<Category>
    var categoryList: HasCategoryList = []

    let cancelDone: String

    init(
        _ store: EditableStore,
        context: NSManagedObjectContext,
        categories: FetchedResults<Category>
    ) {
        self.store = store
        self.categories = categories
        self.managedObjectContext = context
        self.cancelDone = store.isEdit ? "Cancel" : "Done"
        categoryList = categories.map {
            HasCategory($0, self.store.categories.contains($0))
        }
    }

    func updateStore() {
        // update store.categories
        store.categories = Set(categoryList.filter({ $0.included }).map({ $0.category }))
        if store.isEdit {
            store.update()
        } else {
            store.add(context: managedObjectContext)
        }
        managedObjectContext.persist()
        if store.isEdit { mode.wrappedValue.dismiss() }
    }

    var body: some View {
        VStack {
            Spacer()
            InputText(
                " Name",
                text: $store.name,
                onCommit: { self.updateStore() }
            )
            InputText(
                "Branch",
                text: $store.branch,
                onCommit: { self.updateStore() }
            )
            CategoriesSelector(categoriesList: categoryList)
            Spacer()
            HStack {
                Button(
                    action: { self.mode.wrappedValue.dismiss() },
                    label: { EncapsulatedText(cancelDone) }
                )
                Button(
                    action: { self.updateStore() },
                    label: { EncapsulatedText(self.store.label) }
                )
                .disabled(self.store.name.isEmpty)
            }
        }
        .padding(.horizontal, 20)
    }
}
