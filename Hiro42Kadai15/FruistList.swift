//
//  FruistList.swift
//  Hiro42Kadai15
//
//  Created by 白石裕幸 on 2021/12/06.
//

import Foundation

class FruistList {
    public var fruitsInStock = [CheckItem]()
    init() {
        fruitsInStock.append(CheckItem(name: "りんご", isChecked: false))
        fruitsInStock.append(CheckItem(name: "みかん", isChecked: true))
        fruitsInStock.append(CheckItem(name: "バナナ", isChecked: false))
        fruitsInStock.append(CheckItem(name: "パイナップル", isChecked: true))
    }
}
