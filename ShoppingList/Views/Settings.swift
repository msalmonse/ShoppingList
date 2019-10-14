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
    var settings = UserSettings.global
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
                Spacer()
                VStack(alignment: .leading) {
                    Text("Chosen")
                    HStack {
                        Text("Category:")
                        .frame(width: 80, alignment: .trailing)
                        Text(settings.chosenCategory)
                    }
                    HStack {
                        Text("Store:")
                        .frame(width: 80, alignment: .trailing)
                        Text(settings.chosenStore)
                    }
                }
                .frame(width: 250)
                .modifier(RoundedBorder())
                .layoutPriority(2.0)
                Spacer()
            }
            Spacer()
            HStack {
                Spacer()
                Text(nameVersion)
                Spacer()
            }
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
