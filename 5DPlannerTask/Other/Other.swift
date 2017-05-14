//
//  Other.swift
//  5DPlannerTask
//
//  Created by Darius Miliauskas on 13/05/2017.
//  Copyright © 2017 Darius Miliauskas. All rights reserved.
//

//https://medium.com/@avihay/amazing-physically-based-rendering-using-the-new-ios-10-scenekit-2489e43f7021#.vdapbrnj7
//https://www.weheartswift.com/introduction-scenekit-part-1/
//http://stackoverflow.com/questions/27509092/scnbox-different-colour-or-texture-on-each-face
//http://stackoverflow.com/questions/39439216/swift-must-call-a-designated-initializer-of-the-superclass-error-even-though

import Foundation

enum Element: String {
    case Room = "Room"
    case Floor = "Floor"
    case Wall = "Wall"
    case Point = "Point"

    var parameters: [String] {
        switch self {
        case .Room:
            return ["x", "y", "z", "h"]
        case .Floor:
            return ["h"]
        case .Wall:
            return ["w"]
        case .Point:
            return ["x", "y"]
        }
    }
}

//@objc protocol ItemsExtractProtocol: DataExtractProtocol {
//    optional func extractItems(input: [String : AnyObject]) -> [AnyObject]
//}
//
//extension ItemsExtractProtocol {
//    func extractItems(input: [String : AnyObject]) -> [AnyObject] {
//        if let items = extractData(input: input, using: "items") as? [AnyObject] {
//            return items
//            //            for item in items {
//            //                if let theItem = item as? [String : AnyObject] {
//            //
//            //                }
//            //            }
//        }
//        return []
//    }
//}

class Other {

// MARK: Extracting Data

/*
 
 //Extracting the properties like className, h etc.
 func extractItemProperties(_ input: [String: AnyObject]) {
 if let className = extractData(input: input, using: "className") as? String  {
 print(className)
 if let type = Element(rawValue: className) {
 for parameter in type.parameters {
 if let value = extractData(input: input, using: parameter) as? NSNumber {
 print(parameter+": \(value)")
 }
 }
 }
 
 //check if materials can be extracted since not all objects have materials
 if className == "Room" || className == "Wall" {
 self.extractItemMaterials(input)
 }
 
 if className != "Point" {
 extractItems(input: input)
 }
 }
 }
 
 func extractItemMaterials(_ input: [String: AnyObject]) {
 if let materials = extractData(input: input, using: "materials") as? [String:AnyObject]  {
 for side in ["indoor", "outdoor", "floor", "ceil"] {
 if let feature = extractData(input: materials, using: side) as? [String:AnyObject] {
 extractMaterial(feature)
 }
 }
 }
 }
 
 func extractItems(input: [String: AnyObject]) {
 if let items = extractData(input: input, using: "items") as? [AnyObject]  {
 for item in items {
 if let theItem = item as? [String : AnyObject] {
 extractItemProperties(theItem)
 //                    extractItems(input: theItem)
 }
 }
 }
 }*/
}
