//
//  TheWall.swift
//  5DPlannerTask
//
//  Created by Darius Miliauskas on 12/04/2017.
//  Copyright © 2017 Darius Miliauskas. All rights reserved.
//

import UIKit
import SceneKit

// MARK: Scene Basic Nodes

class CameraNode: SCNNode {
     override init() {
        super.init()
        let camera = SCNCamera()
        camera.automaticallyAdjustsZRange = true //otherwise the object disappears: width:camera-z 70-134, 50-125, 10-104
        //camera.xFov = 75.0
        //camera.yFov = 75.0
        self.camera = camera
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
}

class LightNode: SCNNode  {
    //var color: UIColor?
    
    init(type: SCNLight.LightType) {
        super.init()
        let theLight = SCNLight()
        theLight.type = type
        self.light = theLight
        
//        if theLight.type == .omni {
//            self.position = SCNVector3(x: 0, y: 10, z: 10)
//        }
//
//        if let theColor = color, theLight.type == .ambient {
//            theLight.color = theColor
//        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Scene Object Material

class DMMaterial: SCNMaterial {
    init(_ material: Material, scale: Float) {
        super.init()
        if let imageName = material.imageName, let color = material.color {
            self.diffuse.contents = UIImage(named: imageName)
            //http://stackoverflow.com/questions/39541747/scenekit-increase-sharpness-of-texture-used-for-scnnode-material
            self.diffuse.contentsTransform = SCNMatrix4MakeScale(scale, scale, scale)
            self.diffuse.wrapS = .repeat
            self.diffuse.wrapT = .repeat
            self.multiply.contents = color
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Scene Object Nodes

class GroundNode: SCNNode {
    init(_ project: Project) {
        super.init()
        if let width = project.width, let height = project.height {
            let geometry = SCNPlane(width: width, height: height)
            if let material = project.ground {
                geometry.firstMaterial = DMMaterial(material, scale: 100)
            }
            self.geometry = geometry
            self.position = SCNVector3(x: 0.0, y: 0.0, z: 0.0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
}

class RoomNode: SCNNode {
    init(_ room: Room) {
        super.init()
        if let x = room.x, let y = room.y, let z = room.z {
            self.position = SCNVector3(x: x/2, y: y/2, z: z/2)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
}

class FloorNode: SCNNode {
    init(side: CGFloat, material: Material?) {
        super.init()
        let geometry = SCNPlane(width: side , height: side)
        if let material = material {
            geometry.firstMaterial = DMMaterial(material, scale: 2)
        }
        //self.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        self.geometry = geometry
        self.position = SCNVector3(x: Float(side/2), y: Float(side/2), z: 3.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
}

class WallNode: SCNNode {
    var width: CGFloat = 0.0
    var height: CGFloat = 0.0
    var length: CGFloat = 0.0
    var materials: [DMMaterial] = []
    
    init(_ wall: Wall) {
        super.init()
        setup(wall: wall)
        setupMaterial(wall: wall)
        let geometry = SCNBox(width: width, height: height, length: length, chamferRadius: 0)
        geometry.materials = materials
        self.geometry = geometry
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(wall: Wall) {
        guard let point1 = wall.points.first, let point2 = wall.points.last else {
            return
        }
        
        guard let x1 = point1.pointX, let y1 = point1.pointY else {
            return
        }
        
        guard let x2 = point2.pointX, let y2 = point2.pointY else {
            return
        }
        
        self.position = SCNVector3(x: Float((x2+x1)/2), y: Float((y2+y1)/2), z: 0)
        let height = CGFloat(sqrt(Double(pow((x2-x1), 2) + pow((y2-y1), 2))))
        if let width = wall.w, let length = wall.h {
            self.length = length
            
            if x1 == x2 {
                self.width = width
                self.height = height+width
            }
            
            if y1 == y2 {
                self.width = height+width
                self.height = width
            }
        }
    }
    
    func setupMaterial(wall: Wall) {
        guard let wallMaterials = wall.materials, let materials = wallMaterials.materials else {
            return
        }
        for material in materials.values {
            self.materials.append(DMMaterial(material as! Material, scale: 10))
        }
    }
}

class Skydome: SCNNode {
    
    override init() {
        super.init()
        let geometry = SCNSphere(radius: 8000.0)
        let material = SCNMaterial()
        //material.diffuse.contents = UIImage(named: "environment.jpg")
        material.diffuse.contents = UIColor.blue
        material.isDoubleSided = true
        geometry.firstMaterial = material
//        material.diffuse.contentsTransform = SCNMatrix4MakeScale(20, 20, 20)
//        material.diffuse.wrapS = .repeat
//        material.diffuse.wrapT = .repeat
        self.geometry = geometry
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
}
