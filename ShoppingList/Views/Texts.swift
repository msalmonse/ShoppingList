//
//  Texts.swift
//  ShoppingList
//
//  Created by Michael Salmon on 2019-10-06.
//  Copyright © 2019 mesme. All rights reserved.
//

import SwiftUI

struct ButtonText: View {
    let text: String
    let disabled: Bool

    init(_ text: String, _ disabled: Bool = false) {
        self.text = text
        self.disabled = disabled
    }
    var body: some View {
        Text(text)
        .foregroundColor(disabled ? .secondary : .primary)
    }
}

struct EncapsulatedText: View {
    let text: String
    let disabled: Bool

    init(_ text: String, _ disabled: Bool = false) {
        self.text = text
        self.disabled = disabled
    }
    var body: some View {
        Text(text)
        .padding(.horizontal, 5)
        .foregroundColor(disabled ? .secondary : .primary)
        .clipShape(Capsule())
        .overlay(Capsule().stroke(lineWidth: 1).foregroundColor(.primary))
        .padding(5)
    }
}
