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
        //print(parseJSON(fileName: "JSONData"))
        extract(input: parseJSON(fileName: "JSONData"))
        
        
        
    }
    
    
    func extract(input: [String: AnyObject]) {
        
        if let projectName = extractData(input: input, using: "name") as? String {
            print(projectName)
        }
        
        if let data = extractData(input: input, using: "data") as? [String: AnyObject] {
            //            let width = extractData(input: data, using: "width")
            //            let height = extractData(input: data, using: "height")
//            if let ground = extractData(input: data, using: "ground") as? [String: AnyObject]  {
//                extractMaterial(ground)
//            }
            extractItems(input: data)
        }
    }
    
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
        }
    }
    
    func extractItemMaterials(_ input: [String: AnyObject]) {
        if let materials = extractData(input: input, using: "materials") as? [String:AnyObject]  {
            if let indoor = extractData(input: materials, using: "indoor") as? [String:AnyObject] {
                extractMaterial(indoor)
            }
            if let outdoor = extractData(input: materials, using: "outdoor") as? [String:AnyObject] {
                extractMaterial(outdoor)
            }
        }
    }
    
    func extractMaterial(_ material: [String: AnyObject]) {
        if let color = extractData(input: material, using: "color") as? String {
            print("Color: \(color)")
        }
        if let texture = extractData(input: material, using: "texture") as? String {
            print("Texture: \(texture)")
        }
    }
    
    func extractItems(input: [String: AnyObject]) {
        if let items = extractData(input: input, using: "items") as? [AnyObject]  {
            for item in items {
                if let theItem = item as? [String : AnyObject] {
                    extractItemProperties(theItem)
                    extractItemMaterials(theItem)
                    extractItems(input: theItem)
                }
            }
        }
    }
    
    func extractData(input: [String: AnyObject], using keyword: String) -> AnyObject? {
        if let value = input[keyword] {
            return value
        } else {
            print("The key \(keyword) does not exist in dictionary.")
            return nil
            //return input as AnyObject
        }
    }
    
    func parseJSON(fileName: String) -> [String: AnyObject] {
        if let url: URL = Bundle.main.url(forResource: fileName, withExtension: "json") {
            if let data = NSData(contentsOf: url) {
                do {
                    let object = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments)
                    if let array = object as? [String: AnyObject] {
                        return array
                    }
                } catch {
                    print("Error!! Unable to parse  \(fileName).json")
                }
            }
            print("Error!! Unable to load  \(fileName).json")
        }
        print("Error!! The wrong file name or the file does not exist. NB! The file name should be without the extention.")
        return [:]
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
        case nil:
            return []
        }
    }
}
