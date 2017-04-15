//
//  ViewController.swift
//  5DPlannerTask
//
//  Created by Darius Miliauskas on 23/03/2017.
//  Copyright © 2017 Darius Miliauskas. All rights reserved.
//

import UIKit
import SceneKit

//https://medium.com/@avihay/amazing-physically-based-rendering-using-the-new-ios-10-scenekit-2489e43f7021#.vdapbrnj7
//https://www.weheartswift.com/introduction-scenekit-part-1/

class ViewController: UIViewController {
    
    @IBOutlet weak var sceneView: SCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //render()
        run()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func render() {
        sceneView.scene = CustomScene()
        sceneView.backgroundColor = UIColor.black
        sceneView.allowsCameraControl = true
    }
    
    
    func run() {
        //let data: [String : AnyObject]=[:]
            let input = JSONData.parseJSON(fileName: "JSONData")
            let json = JSON(input: input)
            let project = Project(dataWithoutMaterial: json.data!)
            project.extract(json.data!)
            
            for item in project.items! {
                let floor = Floor(dataWithoutMaterial: item)
                floor.extract(item)
                for item in floor.items! {
                    let room = Room(data: item)
                    room.extract(item)
                    for item in room.items! {
                        let wall = Wall(data: item)
                        wall.extract(item)
                    }
                }
                //             let wallGeometry = SCNBox(width: point.w, height: point.h, length: point.x, chamferRadius: 0.0)
            }

        
        
        
        //print(parseJSON(fileName: "JSONData"))
//        let json = JSON()
         //json.extract(fileName: "JSONData")
        

        //JSON(input: input)
        
//        let project = Project(json: JSON(fileName: "JSONData"))
    }
    
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

protocol ExtractProtocol {
    func extract(_ item: [String : AnyObject])
}

//protocol ItemsExtractProtocol: DataExtractProtocol {
//    func extractItems(input: [String : AnyObject]) -> [AnyObject]
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

protocol DataExtractProtocol {
    func extractData(input: [String: AnyObject], using keyword: String) -> AnyObject?
}

extension DataExtractProtocol {
    //The method get the value using keyword (the basic method)
    func extractData(input: [String: AnyObject], using keyword: String) -> AnyObject? {
        if let value = input[keyword] {
            return value
        } else {
            print("The key \(keyword) does not exist in dictionary.")
            return nil
            //return input as AnyObject
        }
    }
}





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
