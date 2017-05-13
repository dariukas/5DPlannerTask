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
        setupScene()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupScene() {
        let omniLight = LightNode(type: .omni)
        omniLight.position = SCNVector3(x: 0, y: 10, z: 10)
        self.rootNode.addChildNode(omniLight)
        
        let ambientLight = LightNode(type: .ambient)
        ambientLight.color = UIColor.darkGray
        self.rootNode.addChildNode(ambientLight)
        
        let camera = CameraNode()
        camera.position = SCNVector3(x: 0, y: 0, z: 15)
        self.rootNode.addChildNode(camera)

        setupEnviromentLights()
    }
    
    private func setupEnviromentLights() {
        let environment = UIImage(named: "IBL.png")
        self.lightingEnvironment.contents = environment
        self.lightingEnvironment.intensity = 2.0
    }
}
