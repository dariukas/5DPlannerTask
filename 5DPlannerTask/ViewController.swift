//
//  ViewController.swift
//  5DPlannerTask
//
//  Created by Darius Miliauskas on 23/03/2017.
//  Copyright © 2017 Darius Miliauskas. All rights reserved.
//

import UIKit
import SceneKit

//https://planner5d.com/editor/?key=63a807e2624cec7a705c46b74fcbe64b

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
        //sceneView.backgroundColor = UIColor.black
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
                        
                        for item in wall.items! {
                           let point = Point(data: item)
                            point.extract(item)
                            wall.points.append(point)
                        }
                        
                        let wallNode = WallNode()
                        wallNode.setup(wall: wall)
//                        node.addChildNode(wallNode)
                    }
                }
            }
        
        //print(parseJSON(fileName: "JSONData"))
//        let json = JSON()
        //json.extract(fileName: "JSONData")
        
        
        //JSON(input: input)
        
        //        let project = Project(json: JSON(fileName: "JSONData"))
    }
}

protocol ExtractProtocol {
    func extract(_ item: [String : AnyObject])
}

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
