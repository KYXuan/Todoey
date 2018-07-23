//
//  Item.swift
//  Todoey
//
//  Created by 宣柯宇 on 2018-07-22.
//  Copyright © 2018 keyu xuan. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date?
    
    //property:name of the forward relationship
    //Category is class name , Category.self is the type
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
