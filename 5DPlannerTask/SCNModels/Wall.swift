//
//  Wall.swift
//  5DPlannerTask
//
//  Created by Darius Miliauskas on 10/04/2017.
//  Copyright © 2017 Darius Miliauskas. All rights reserved.
//

import UIKit
import SceneKit

class Wall: SCNBox {
    
//    var materials: [SCNMaterial]?
    
    
    convenience init(width: CGFloat, height: CGFloat, length: CGFloat, chamferRadius: CGFloat) {
        self.init(width: width, height: height, length: length, chamferRadius: chamferRadius)
        //self.materials = m
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//    SCNMaterial *greenMaterial              = [SCNMaterial material];
//    greenMaterial.diffuse.contents          = [NSColor greenColor];
//    greenMaterial.locksAmbientWithDiffuse   = YES;
    
}
