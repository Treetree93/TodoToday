//
//  Item.swift
//  TodoToday
//
//  Created by Everett  Sprenger on 2019-08-15.
//  Copyright © 2019 Everett  Sprenger. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
