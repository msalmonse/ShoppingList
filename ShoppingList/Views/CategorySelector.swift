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

    var body: some View {
        VStack {
            Picker(selection: $index, label: Text("")) {
                Text("None").tag(-1)
                ForEach(categories.indices, id: \.self) { index in
                    Text(self.categories[index].name ?? "").tag(index)
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

    @Environment(\.presentationMode)
    var mode: Binding<PresentationMode>

    var body: some View {
        VStack {
            CategorySelector(index: $index, categories: categories)
            HStack {
                Button(
                    action: {
                        self.index = -1
                        self.mode.wrappedValue.dismiss()
                    },
                    label: { EncapsulatedText("Clear") }
                )
                Button(
                    action: { self.mode.wrappedValue.dismiss() },
                    label: { EncapsulatedText("Done") }
                )
            }
        }
    }
}
