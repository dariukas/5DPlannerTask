//
//  Material.swift
//  5DPlannerTask
//
//  Created by Darius Miliauskas on 12/04/2017.
//  Copyright © 2017 Darius Miliauskas. All rights reserved.
//

import UIKit
import SceneKit


class Materials: DataExtractProtocol {
    var materials: [String: AnyObject]?
    
    init(_ items: [String : AnyObject]) {
        var materials = [String: Material]()
        for (type, materialData) in items {
            if let theMaterialData = materialData as? [String: AnyObject] {
                materials[type]=Material(theMaterialData)
            }
        }
        self.materials = materials
    }
    
    private func createMaterial(_ material: Material) -> SCNMaterial {
        let scnMaterial = SCNMaterial()
        
        if let name = material.imageName, let image = UIImage(named: name) {
            scnMaterial.diffuse.contents = image
        } else {
            scnMaterial.diffuse.contents = material.color
        }
        return scnMaterial
    }
    //        if let indoor = extractData(input: materials, using: "indoor") as? [String: AnyObject] {
    //            self.materials?.updateValue(indoor as AnyObject, forKey: "indoor")
    //        }
}


class Material: DataExtractProtocol {
    //var texture: UIImage?
    var imageName: String?
    var color: UIColor?
    
//    init(_ material: [String: AnyObject]) {
//        super.init()
//        if let name = self.imageName, let image = UIImage(named: name) {
//            self.diffuse.contents = image
//        } else {
//            self.diffuse.contents = self.color
//        }
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    init(_ data: [String: AnyObject]) {
        if let color = extractData(input: data, using: "color") as? String {
            //self.color = UIColor(hexString: color)
            //            print("Color: \(color)")
        }
        if let texture = extractData(input: data, using: "texture") as? String {
            self.imageName = texture
//            print("Texture: \(texture)")
        }
        //"scale" & "rotate" not extracted
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
