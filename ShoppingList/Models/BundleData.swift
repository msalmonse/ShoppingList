//
//  BundleData.swift
//  ShoppingList
//
//  Created by Michael Salmon on 2019-10-06.
//  Copyright © 2019 mesme. All rights reserved.
//

import Foundation

// swiftlint:disable force_cast
/// # bundledData
/// Fetch data from the bundles info.plist
///
/// Parameter: key - the key for the data
func bundledData(key: String) -> String? {
    guard let object = Bundle.main.object(forInfoDictionaryKey: key) else { return nil }
    if object is String { return object as? String }
    if object is Int { return String(object as! Int) }

    return nil
}

func bundleKeys() -> [String]? {
    let info = Bundle.main.infoDictionary
    let list = info?.keys.sorted()

    return list
}
