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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        render()
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
}
