//
//  StoreSelector.swift
//  ShoppingList
//
//  Created by Michael Salmon on 2019-09-28.
//  Copyright © 2019 mesme. All rights reserved.
//

import SwiftUI

struct StoreSelector: View {
    @Binding
    var index: Int
    let stores: FetchedResults<Store>
    let category: Category?

    var body: some View {
        VStack {
            Picker(selection: $index, label: Text("")) {
                Text("Any").tag(-1)
                ForEach(stores.indices.filter {stores[$0].categoryFilter(category)}, id: \.self) {
                    Text(self.stores[$0].name ?? "").tag($0)
                }
            }
            Text("Store").bold()
        }
        .modifier(RoundedBorder())
    }
}

struct StoreSelectorSheet: View {
    @Binding
    var index: Int
    let stores: FetchedResults<Store>
    let category: Category?

    @Environment(\.presentationMode)
    var mode: Binding<PresentationMode>

    var body: some View {
        VStack {
            StoreSelector(index: $index, stores: stores, category: category)
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
