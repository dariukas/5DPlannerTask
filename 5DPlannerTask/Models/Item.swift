//
//  Item.swift
//  5DPlannerTask
//
//  Created by Darius Miliauskas on 12/04/2017.
//  Copyright © 2017 Darius Miliauskas. All rights reserved.
//

import UIKit

class Item: DataExtractProtocol {
    var items: [[String: AnyObject]]?
    var materials: Materials?

    init(data: [String : AnyObject]) {
       // super.init() in the case NSObject
        if let items = extractData(input: data, using: "items") as? [[String: AnyObject]] {
            self.items = items
        }
        if let materials = extractData(input: data, using: "materials") as? [String: AnyObject] {
            self.materials = Materials(materials)
        }
    }
    
    init(dataWithoutMaterial: [String : AnyObject]) {
        // super.init()
        if let items = extractData(input: dataWithoutMaterial, using: "items") as? [[String: AnyObject]] {
            self.items = items
        }
    }
}

class Project: Item {
    
    var width: CGFloat?
    var height: CGFloat?
    var ground: Material?
    
    func extract(_ data: [String: AnyObject]) {
        if let width =  extractData(input: data, using: "width") as? CGFloat {
            self.width = width
        }
        if let height =  extractData(input: data, using: "height") as? CGFloat {
            self.height = height
        }
        if let ground = extractData(input: data, using: "ground") as? [String: AnyObject]  {
            self.ground = Material(ground)
        }
    }
}

class Floor: Item {
    
    var floor_H: CGFloat?

    func extract(_ item: [String : AnyObject]) {
        if let value =  extractData(input: item, using: "h") as? CGFloat {
            self.floor_H = value
        }
    }
}

class Room: Floor {
    
    var x: Float?
    var y: Float?
    var z: Float?
    var sX: CGFloat?
    var sY: CGFloat?
    var h: CGFloat?

    override func extract(_ item: [String : AnyObject]) {
        if let value =  extractData(input: item, using: "x") as? Float {
            self.x = value
        }
        if let value =  extractData(input: item, using: "y") as? Float {
            self.y = value
        }
        if let value =  extractData(input: item, using: "z") as? Float {
            self.z = value
        }
        if let value =  extractData(input: item, using: "sX") as? CGFloat {
            self.sX = value
        }
        if let value =  extractData(input: item, using: "sY") as? CGFloat {
            self.sY = value
        }
        if let value =  extractData(input: item, using: "h") as? CGFloat {
            self.h = value
        }
    }
}

class Wall: Room {
    
    var w: CGFloat? //width
    var points: [Point] = []
    
    override init(data: [String : AnyObject]) {
        super.init(data: data)
        for item in self.items! {
            let point = Point(item)
            self.points.append(point)
        }
    }
    
    override func extract(_ item: [String : AnyObject]) {
        if let value =  extractData(input: item, using: "w") as? CGFloat {
            self.w = value
        }
    }
}

class Point: DataExtractProtocol {
    
    var pointX: CGFloat?
    var pointY: CGFloat?
    
    init(_ item: [String : AnyObject]) {
        if let value =  extractData(input: item, using: "x") as? CGFloat {
            self.pointX = value
        }
        if let value = extractData(input: item, using: "y") as? CGFloat {
            self.pointY = value
        }
    }
    
//    override func extract(_ item: [String : AnyObject]) {
//        if let value =  extractData(input: item, using: "x") as? CGFloat {
//            self.pointX = value
//        }
//        if let value = extractData(input: item, using: "y") as? CGFloat {
//            self.pointY = value
//        }
//    }
}
