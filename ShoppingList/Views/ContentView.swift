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

    init() {
        let appearance = UINavigationBar.appearance()
        appearance.barTintColor =
            UIColor(hue: 0.5, saturation: 0.5, brightness: 1.0, alpha: 1.0)
    }

    var body: some View {
        ZStack {
            Color(hue: 0.5, saturation: 0.1, brightness: 1.0)
            NavigationView {
                HStack(alignment: .top) {
                    StoresView()
                    ProductsView()
                }
            .navigationBarTitle(Text("Shopping List"), displayMode: .inline)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
