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
    convenience override init() {
        self.init()
        self.camera = SCNCamera()
    }
}

class LightNode: SCNNode  {
    internal var theLight = SCNLight()
    var color: UIColor?
    
    convenience init(type: SCNLight.LightType) {
        self.init()
        theLight.type = type
        self.light = theLight
        
        if theLight.type == .omni {
            self.position = SCNVector3(x: 0, y: 10, z: 10)
        }
        
        if let theColor = color, theLight.type == .ambient {
            theLight.color = theColor
        }
    }
}

// MARK: Scene Object Nodes

class WallNode: SCNNode {
    var width: CGFloat = 0.0
    var height: CGFloat = 0.0
    var length: CGFloat = 0.0
    var material: Material?
    
    convenience override init() {
        self.init()
        let geometry = SCNBox(width: width, height: height, length: length, chamferRadius: 0)
        self.geometry = geometry
        self.position = SCNVector3(x: 0, y: 0, z: 0)
        if let imageName = material?.imageName, let color = material?.color {
            geometry.firstMaterial?.diffuse.contents = color
            geometry.firstMaterial?.diffuse.contents = UIImage(named: imageName)
        }
    }
    
    func setup(wall: Wall) {
//        self.init()
        guard let point1 = wall.points.first, let point2 = wall.points.last else {
            return
        }
        
        guard let x1 = point1.pointX, let y1 = point1.pointY else {
            return
        }
        
        guard let x2 = point2.pointX, let y2 = point2.pointY else {
            return
        }
        
        self.position = SCNVector3(x: Float(x1), y: Float(y1), z: 0)
        let height = CGFloat(sqrt(Double(x1*x2 + y1*y2)))
        
        if let width = wall.w, let length = wall.h {
            self.length = length
            
            if x1 == x2 {
                self.width = width
                self.height = height
            }
            
            if y1 == y2 {
                self.width = height
                self.height = width
            }
        }
    }
}

class SphereNode: SCNNode {
    var radius: CGFloat? = 1.0
    var color: UIColor?
    var material: Material?
    
    convenience override init() {
        self.init()
        if let radius = radius, let imageName = material?.imageName, let color = material?.color {
            let sphereGeometry = SCNSphere(radius: radius)
            sphereGeometry.firstMaterial?.diffuse.contents = color
            sphereGeometry.firstMaterial?.diffuse.contents = UIImage(named: imageName)
        }
    }
}

