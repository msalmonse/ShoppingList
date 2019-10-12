//
//  UserSettings.swift
//  ShoppingList
//
//  Created by Michael Salmon on 2019-10-06.
//  Copyright © 2019 mesme. All rights reserved.
//

import Foundation
import Combine
import SwiftUI
import UserDefaults

final class UserSettings: ObservableObject, Identifiable {
    let id = UUID()
    let objectWillChange = ObservableObjectPublisher()

    @UserDefault("ChosenCategory", defaultValue: "")
    var chosenCategory: String

    @UserDefault("ChosenStore", defaultValue: "")
    var chosenStore: String

    init() { return }
}

extension UserSettings {
    private static var global = UserSettings()

    static var chosenCategory: String {
        get { global.chosenCategory }
        set { global.chosenCategory = newValue }
    }

    static var chosenStore: String {
        get { global.chosenStore }
        set { global.chosenStore = newValue }
    }
}
