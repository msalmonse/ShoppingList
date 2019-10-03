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
    let categories: FetchedResults<Category>

    @State
    var index: Int = 0

    var body: some View {
        Picker(selection: $index, label: Text("Category")) {
            ForEach(categories.indices, id: \.self) { index in
                Text(self.categories[index].name ?? "").tag(index)
            }
        }
    }
}
