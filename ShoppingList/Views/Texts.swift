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

    @Environment(\.colorScheme)
    var scheme: ColorScheme

    init(_ text: String, _ disabled: Bool = false) {
        self.text = text
        self.disabled = disabled
    }

    var body: some View {
        Text(text)
        .padding(.vertical, 5)
        .padding(.horizontal, 10)
        .foregroundColor(disabled ? .secondary : .primary)
        .background(scheme == .dark ? darkGradient : lightGradient)
        .clipShape(Capsule())
        .padding(5)
    }
}

fileprivate let brightnesses = [ 1.0, 0.9, 0.8, 0.8, 0.8, 0.7, 0.6, 0.5 ]
fileprivate let minBrightness = brightnesses.min() ?? 0.0
fileprivate let darkGradient = LinearGradient(
    gradient: Gradient(colors:
        brightnesses.map { Color(hue: 0, saturation: 0, brightness: $0 - minBrightness, opacity: 1) }
    ),
    startPoint: .top,
    endPoint: .bottom
)
fileprivate let lightGradient = LinearGradient(
    gradient: Gradient(colors:
        brightnesses.map { Color(hue: 0, saturation: 0, brightness: $0, opacity: 1) }
    ),
    startPoint: .top,
    endPoint: .bottom
)
