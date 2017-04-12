//
//  Item.swift
//  5DPlannerTask
//
//  Created by Darius Miliauskas on 12/04/2017.
//  Copyright © 2017 Darius Miliauskas. All rights reserved.
//

import UIKit

class Item: Project {

}


class Floor: Project {
    var floor_H: Float?
    var ite
    
    init(item: [String : AnyObject]) {
        super.init(data: item)
        for item in self.items1! {
            if let theItem = item as? [String : AnyObject] {
                if let floorH =  JSON.extractData(input: theItem, using: "h") as? Float {
                    self.floor_H = floorH
                    print(floorH)
                }
            }
            if let items = JSON.extractData(input: theItem, using: "items") as? [AnyObject]  {
                self.items1 = items
            }

        }
    }
}

class Room: Floor {
    var x: CGFloat?
    var y: CGFloat?
    var z: CGFloat?
    var sX: CGFloat?
    var sY: CGFloat?
    var h: CGFloat?
    
    init(item: [String : AnyObject]) {
        super.init(data: item)
    }
    
    
}

class Wall: Room {
    var w: CGFloat? //width
}


//class Point: Wall {
//    var pointX: CGFloat?
//    var pointY: CGFloat?
//    
//    init(wall: Wall) {
//        if let width =  JSON.extractData(input: json.data!, using: "width") as? Float {
//            self.width = width
//        }
//        if let height =  JSON.extractData(input: json.data!, using: "height") as? Float {
//            self.height = height
//        }
//        if let ground = JSON.extractData(input: json.data!, using: "ground") as? [String: AnyObject]  {
//            //            self.ground = extractMaterial(ground)
//        }
//    }
//}
