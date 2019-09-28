//
//  StoreAdd.swift
//  ShoppingList
//
//  Created by Michael Salmon on 2019-09-27.
//  Copyright © 2019 mesme. All rights reserved.
//

import SwiftUI

struct StoreAddLink: View {
    var body: some View {
        NavigationLink(
            destination: StoreAdd(),
            label: { Text("Add Store") }
        )
    }
}

struct StoreAdd: View {
    @Environment(\.managedObjectContext)
    var managedObjectContext
    @Environment(\.presentationMode)
    var mode: Binding<PresentationMode>

    @State
    var name = ""
    @State
    var branch = ""

    var body: some View {
        VStack {
            TextField("Store name", text: $name)
            TextField("Store branch", text: $branch)
            Button(
                action: {
                    let store = Store(context: self.managedObjectContext)
                    store.id = UUID()
                    store.name = self.name
                    store.branch = self.branch.isEmpty ? nil : self.branch
                    self.managedObjectContext.persist()
                    // clean up for next time
                    self.name = ""
                    self.branch = ""
                    self.mode.wrappedValue.dismiss()
                },
                label: { Text("Add")}
            )
            .disabled(name.isEmpty)
        }
        .padding(.horizontal, 20)
    }
}

struct StoreAdd_Previews: PreviewProvider {
    static var previews: some View {
        StoreAdd()
    }
}
