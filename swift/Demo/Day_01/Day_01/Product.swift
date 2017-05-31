//
//  Product.swift
//  Day_01
//
//  Created by wyy on 2017/5/31.
//  Copyright © 2017年 wyy. All rights reserved.
//

import UIKit

class Product: NSObject {
    var name:String?
    var cellImageName:String?
    var fullScreenImageName:String?
    
    init(name:String, cellImageName:String, fullScreenImageName:String) {
        self.name = name
        self.cellImageName = cellImageName
        self.fullScreenImageName = fullScreenImageName
    }
}
