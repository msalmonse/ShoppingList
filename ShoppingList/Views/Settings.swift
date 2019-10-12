//
//  Settings.swift
//  ShoppingList
//
//  Created by Michael Salmon on 2019-09-28.
//  Copyright © 2019 mesme. All rights reserved.
//

import UserDefaults
import SwiftUI

struct Settings: View {
    @ObservedObject
    var settings = UserSettings()
    let nameVersion: String

    init() {
        let name = bundledData(key: "CFBundleName")
        let version = bundledData(key: "CFBundleShortVersionString")
        let build = bundledData(key: "CFBundleVersion")

        var string = ""
        if name != nil {
            string = name!
            if version != nil {
                string += " - \(version!)"
                if build != nil {
                    string += "(\(build!))"
                }
            }
        }
        self.nameVersion = string
    }

    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            HStack {
                Text("Chosen Category:")
                .frame(width: 160, alignment: .trailing)
                Text(UserSettings.chosenCategory)
            }
            HStack {
                Text("Chosen Store:")
                .frame(width: 160, alignment: .trailing)
                Text(UserSettings.chosenStore)
            }
            Spacer()
            Text(nameVersion)
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
