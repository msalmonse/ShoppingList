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

    var body: some View {
        VStack {
            Picker(selection: $index, label: Text("")) {
                Text("Any").tag(-1)
                ForEach(stores.indices, id: \.self) { index in
                    Text(self.stores[index].name ?? "").tag(index)
                }
            }
            Text("Store").bold()
        }
        .modifier(PickerBorder())
    }
}

struct StoreSelectorSheet: View {
    @Binding
    var index: Int
    let stores: FetchedResults<Store>

    @Environment(\.presentationMode)
    var mode: Binding<PresentationMode>

    var body: some View {
        VStack {
            StoreSelector(index: $index, stores: stores)
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
