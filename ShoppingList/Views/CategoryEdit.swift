//
//  CategoryEdit.swift
//  ShoppingList
//
//  Created by Michael Salmon on 2019-09-30.
//  Copyright © 2019 mesme. All rights reserved.
//

import SwiftUI

struct CategoryEdit: View {
    @Environment(\.managedObjectContext)
    var managedObjectContext
    @Environment(\.presentationMode)
    var mode: Binding<PresentationMode>

    @ObservedObject
    var category: EditableCategory

    init(_ category: EditableCategory) {
        self.category = category
    }

    var body: some View {
        VStack {
            TextField("Category name", text: $category.name)
            Button(
                action: {
                    self.category.update(self.managedObjectContext)
                    self.mode.wrappedValue.dismiss()
                },
                label: { Text(self.category.label) }
            )
            .disabled(category.name.isEmpty)
        }
        .padding(.horizontal, 20)
    }
}

struct CategoryEdit_Previews: PreviewProvider {
    static var previews: some View {
        CategoryEdit(EditableCategory())
    }
}
