//
//  Category.swift
//  Todoey
//
//  Created by 宣柯宇 on 2018-07-22.
//  Copyright © 2018 keyu xuan. All rights reserved.
//

import Foundation
import RealmSwift


class Category : Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
    
}
