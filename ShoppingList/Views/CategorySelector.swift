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
        Picker(selection: $index, label: Text("Category")) {
            Text("None").tag(-1)
            ForEach(categories.indices, id: \.self) { index in
                Text(self.categories[index].name ?? "").tag(index)
            }
        }
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
            HStack {
                Text("Category")
                Button(
                    action: {
                        self.categoriesList[self.index].included.toggle()
                    },
                    label: { Text(categoriesList[index].included ? "Remove" : "Add") }
                )
            }
        }
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
