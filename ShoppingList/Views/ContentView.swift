//
//  ContentView.swift
//  ShoppingList
//
//  Created by Michael Salmon on 2019-09-26.
//  Copyright © 2019 mesme. All rights reserved.
//

import SwiftUI
import UIKit

struct ContentView: View {
    var body: some View {
        TabView {
            EntriesView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
            }

            CategoriesView()
                .tabItem {
                    Image(systemName: "tray.2")
                    Text("Categories")
            }

            ProductsView()
                .tabItem {
                    Image(systemName: "rectangle.stack")
                    Text("Products")
            }

            StoresView()
                .tabItem {
                    Image(systemName: "cart")
                    Text("Stores")
            }

            Settings()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
