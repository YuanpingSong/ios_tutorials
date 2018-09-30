//
//  Checklist.swift
//  Checklists
//
//  Created by imac on 2017/6/28.
//  Copyright © 2017年 Individual. All rights reserved.
//

import UIKit

class Checklist: NSObject, NSCoding {
    var name : String
    var iconName: String
    var items: [ChecklistItem]
    
    convenience init(name: String) {
        self.init(name: name, iconName: "No Icon")
    }
    
    init(name: String, iconName: String) {
        self.name = name
        self.iconName = iconName
        items = [ChecklistItem]()
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "Name") as! String
        items = aDecoder.decodeObject(forKey: "Items") as! [ChecklistItem]
        iconName = aDecoder.decodeObject(forKey: "iconName") as! String
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "Name")
        aCoder.encode(items, forKey: "Items")
        aCoder.encode(iconName, forKey: "iconName")
    }
    
    func countUnCheckedItems() -> Int {
        var count = 0
        for item in items where !item.checked {
            count += 1
        }
        return count
    }
    
}
