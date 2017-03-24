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
        render()
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
        return [:]
    }
}

