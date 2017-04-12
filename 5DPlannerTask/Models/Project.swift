//
//  Project.swift
//  5DPlannerTask
//
//  Created by Darius Miliauskas on 12/04/2017.
//  Copyright © 2017 Darius Miliauskas. All rights reserved.
//

import UIKit

class Project: JSON {
    
    var width: Float?
    var height: Float?
    var ground: Material?
    var items: [String: AnyObject]?
    var items1: [AnyObject]?
    
    init(data: [String : AnyObject]) {
        super.init(input: data)
        
        if let data = self.data {
            if let width =  JSON.extractData(input: data, using: "width") as? Float {
                self.width = width
            }
            
            if let height =  JSON.extractData(input: data, using: "height") as? Float {
                self.height = height
            }
            
            if let ground = JSON.extractData(input: data, using: "ground") as? [String: AnyObject]  {
                //            self.ground = extractMaterial(ground)
            }
            
            if let items = JSON.extractData(input: data, using: "items") as? [AnyObject]  {
                self.items1 = items
//                for item in items {
//                    if let theItem = item as? [String : AnyObject] {
//                        
//                        // let floor = Floor(item: theItem)
//                    }
//                }
            }
        }
        
        //        func extractItems(input: [String: AnyObject]) {
        //            if let items = extractData(input: input, using: "items") as? [AnyObject]  {
//                for item in items {
//                    if let theItem = item as? [String : AnyObject] {
//                        extractItemProperties(theItem)
//                        //                    extractItems(input: theItem)
//                    }
//                }
//            }
//        }
    }

    // MARK: Parsing JSON
    
//    //The main method to extract data
//    func extract(input: [String: AnyObject]) {
//        if let projectName = JSON.extractData(input: input, using: "name") as? String {
//            print(projectName)
//        }
//        if let data = JSON.extractData(input: input, using: "data") as? [String: AnyObject] {
//            //            let width = extractData(input: data, using: "width")
//            //            let height = extractData(input: data, using: "height")
//            //            if let ground = extractData(input: data, using: "ground") as? [String: AnyObject]  {
//            //                extractMaterial(ground)
//            //            }
//            extractItems(input: data)
//        }
//    }

}
