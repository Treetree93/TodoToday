//
//  Category.swift
//  TodoToday
//
//  Created by Everett  Sprenger on 2019-08-15.
//  Copyright © 2019 Everett  Sprenger. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
}
