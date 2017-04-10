//
//  CustomScene.swift
//  5DPlannerTask
//
//  Created by Darius Miliauskas on 23/03/2017.
//  Copyright © 2017 Darius Miliauskas. All rights reserved.
//

import UIKit
import SceneKit

class CustomScene: SCNScene {
    
    override init() {
        super.init()
        //let scene = SCNScene(named: "sphere.obj")!
        //let scnView = self as! SCNView
        addCamera()
        addLights() 
        addSphere()
//        let background = UIImage(named: "IBLBlurred.png")
//        scene.background.contents = background
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addObjects() {
        // retrieve the ship node
        //let ship = self.rootNode.childNode(withName: "ship", recursively: true)!
    }
    
    func addSphere() {
        let sphereGeometry = SCNSphere(radius: 1.0)
        let sphereNode = SCNNode(geometry: sphereGeometry)
        sphereGeometry.firstMaterial?.diffuse.contents = UIColor.red
        self.rootNode.addChildNode(sphereNode)
    }

    func addCamera() {
        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        self.rootNode.addChildNode(cameraNode)
        
        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 15)
    }
    
    func addLights() {
        // create and add a light to the scene
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        self.rootNode.addChildNode(lightNode)
        
        // create and add an ambient light to the scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = .ambient
        ambientLightNode.light!.color = UIColor.darkGray
        self.rootNode.addChildNode(ambientLightNode)
    }
    
    func addEnviromentLights() {
        let environment = UIImage(named: "IBL.png")
        self.lightingEnvironment.contents = environment
        self.lightingEnvironment.intensity = 2.0
    }
}
