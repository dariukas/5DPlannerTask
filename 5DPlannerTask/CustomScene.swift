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
        setObjects()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupScene() {
//        let omniLight = LightNode(type: .omni)
//        omniLight.position = SCNVector3(x: 0, y: 500, z: 500)
//        self.rootNode.addChildNode(omniLight)
        
        let ambientLight = LightNode(type: .ambient)
        ambientLight.light?.color = UIColor.darkGray
        self.rootNode.addChildNode(ambientLight)
        
        let camera = CameraNode()
        camera.position = SCNVector3(x: 2550, y: 1500, z: 900)
        camera.eulerAngles = SCNVector3(x: 0.8, y: 0, z: 0.6)
        //camera.rotation = SCNVector4(x: 0, y: 2, z: 0, w: 0)
        self.rootNode.addChildNode(camera)

        setupEnviromentLights()
    }
    
    func setObjects() {
        
        let skydomeNode = Skydome()
        self.rootNode.addChildNode(skydomeNode)
        
        //let data: [String : AnyObject]=[:]
        let input = JSONData.parseJSON(fileName: "JSONData")
        let json = JSON(input: input)
        let project = Project(dataWithoutMaterial: json.data!)
        project.extract(json.data!)
        
        let groundNode = GroundNode(project)
        self.rootNode.addChildNode(groundNode)
        
        for item in project.items! {
            let floor = Floor(dataWithoutMaterial: item)
            floor.extract(item)
            for item in floor.items! {
                let room = Room(data: item)
                room.extract(item)
                
                let roomNode = RoomNode(room)
                groundNode.addChildNode(roomNode)
                
                for item in room.items! {
                    let wall = Wall(data: item)
                    wall.extract(item)
                    wall.h = room.h
                    
                    let wallNode = WallNode(wall)
                    roomNode.addChildNode(wallNode)
                }
                
                if let roomMaterials = room.materials?.materials,  let firstWallNode = roomNode.childNodes.first as? WallNode {
                    let floorNode = FloorNode(side: firstWallNode.width, material: roomMaterials["floor"] as? Material)
                    roomNode.addChildNode(floorNode)
                }
            }
        }
    }
    
    private func setupEnviromentLights() {
        self.lightingEnvironment.contents = UIImage(named: "environment.jpg")
        self.lightingEnvironment.intensity = 2.0
    }
}
