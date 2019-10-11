//
//  Texts.swift
//  ShoppingList
//
//  Created by Michael Salmon on 2019-10-06.
//  Copyright © 2019 mesme. All rights reserved.
//

import SwiftUI

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
        .overlay(Capsule().strokeBorder(lineWidth: 1.0).foregroundColor(.secondary))
        .padding(5)
    }
}

struct ShrinkPressed: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
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

// wrapper for TextField

struct InputText: View {
    let title: String
    @Binding
    var text: String
    let onCommit: (() -> Void)?

    init(_ title: String, text: Binding<String>, onCommit: (() -> Void)? = nil) {
        self.title = title
        self._text = text
        self.onCommit = onCommit
    }

    func doOnCommit() {
        if onCommit != nil { onCommit!() }
    }

    var body: some View {
        HStack {
            Text(title)
            .lineLimit(1)
            .truncationMode(.middle)
            .frame(width: 120, alignment: .trailing)

            TextField("", text: $text, onCommit: { self.doOnCommit() })
            .padding(.horizontal, 5)
            .overlay(RoundedRectangle(cornerRadius: 2).strokeBorder(lineWidth: 1))
            .padding(.horizontal, 10)
        }
    }
}

// border for pickers

struct PickerBorder: ViewModifier {
    func body(content: Content) -> some View {
        content
            .overlay(RoundedRectangle(cornerRadius: 2).strokeBorder(lineWidth: 1))
            .padding(.horizontal, 5)
    }
}
