//
//  CategorySelector.swift
//  ShoppingList
//
//  Created by Michael Salmon on 2019-09-29.
//  Copyright © 2019 mesme. All rights reserved.
//

import SwiftUI

struct CategorySelector: View {
    @Binding
    var index: Int
    let categories: FetchedResults<Category>
    let store: Store?

    var body: some View {
        VStack {
            Picker(selection: $index, label: Text("")) {
                Text("None").tag(-1)
                ForEach(categories.indices.filter { categories[$0].storeFilter(store)}, id: \.self) {
                    Text(self.categories[$0].name ?? "").tag($0)
                }
            }
            Text("Category").bold()
        }
        .modifier(PickerBorder())
    }
}

struct CategoriesSelector: View {
    let categoriesList: HasCategoryList

    @State
    var index: Int = 0

    var body: some View {
        VStack {
            Picker(selection: $index, label: Text("")) {
                ForEach(categoriesList.indices, id: \.self) { index in
                    CategoriesListRow(category: self.categoriesList[index]).tag(index)
                }
            }
            Text("Categories").bold()
            if categoriesList.indices.contains(index) {
                CategoryToggle(category: categoriesList[index])
            }
        }
        .modifier(PickerBorder())
    }
}

struct CategoryToggle: View {
    @ObservedObject
    var category: HasCategory

    var body: some View {
        Button(
            action: {
                self.category.included.toggle()
            },
            label: { EncapsulatedText("\(category.included ? "Remove" : "Add") Category") }
        )
        .buttonStyle(ShrinkPressed())
    }
}

struct CategoriesListRow: View {
    @ObservedObject
    var category: HasCategory

    var body: some View {
        HStack {
            Image(systemName: category.included ? "checkmark.square" : "square")
            Text(category.name)
        }
    }
}

struct CategorySelectorSheet: View {
    @Binding
    var index: Int
    let categories: FetchedResults<Category>
    let store: Store?

    @Environment(\.presentationMode)
    var mode: Binding<PresentationMode>

    var body: some View {
        VStack {
            CategorySelector(index: $index, categories: categories, store: store)
            HStack {
                Button(
                    action: {
                        self.index = -1
                        self.mode.wrappedValue.dismiss()
                    },
                    label: { EncapsulatedText("Clear") }
                )
                .buttonStyle(ShrinkPressed())
                Button(
                    action: { self.mode.wrappedValue.dismiss() },
                    label: { EncapsulatedText("Done") }
                )
                .buttonStyle(ShrinkPressed())
            }
        }
    }
}
