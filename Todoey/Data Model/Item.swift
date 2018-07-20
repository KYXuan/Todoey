//
//  Item.swift
//  Todoey
//
//  Created by 宣柯宇 on 2018-07-20.
//  Copyright © 2018 keyu xuan. All rights reserved.
//

import Foundation

class Item: Encodable,Decodable {
    var title = ""
    var done : Bool = false
}
