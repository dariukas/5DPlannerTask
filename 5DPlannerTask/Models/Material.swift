//
//  Material.swift
//  5DPlannerTask
//
//  Created by Darius Miliauskas on 12/04/2017.
//  Copyright © 2017 Darius Miliauskas. All rights reserved.
//

import UIKit
import SceneKit

class Material: SCNMaterial {
    //var texture: UIImage?
    var imageName: String?
    var color: UIColor?
    
    func extractMaterial(_ material: [String: AnyObject]) {
        //var material: Material = Material()
        if let color = JSON.extractData(input: material, using: "color") as? String {
            self.color = UIColor(hexString: color)
            //            print("Color: \(color)")
        }
        if let texture = JSON.extractData(input: material, using: "texture") as? String {
            self.imageName = texture
            print("Texture: \(texture)")
        }
        //"scale" & "rotate" not extracted
    }
    
    func createMaterial() -> SCNMaterial {
        if let name = self.imageName, let image = UIImage(named: name) {
            self.diffuse.contents = image
        } else {
            self.diffuse.contents = self.color
        }
        return self
    }
}

extension UIColor {
    convenience init(hexString: String) {
        var hex: UInt64 = 000000
        
        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = hexString.substring(from: start)
            hex = UInt64(hexColor)!
        }
        
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
}
