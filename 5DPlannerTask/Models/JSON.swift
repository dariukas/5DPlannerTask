//
//  JSON.swift
//  5DPlannerTask
//
//  Created by Darius Miliauskas on 12/04/2017.
//  Copyright © 2017 Darius Miliauskas. All rights reserved.
//

import UIKit

class JSON: NSObject, DataExtractProtocol {
    var projectName: String?
    var data: [String: AnyObject]?
    
    // MARK: Parsing JSON
    
    init (input: [String: AnyObject]) {
        super.init()
        if let projectName = extractData(input: input, using: "name") as? String {
            self.projectName = projectName
            print(projectName)
        }
        if let data = extractData(input: input, using: "data") as? [String: AnyObject] {
            //Project(data: data)
            self.data = data
            //            print(data)
        }
    }
}

// MARK: Parsing JSON

class JSONData {
    class func parseJSON(fileName: String) -> [String: AnyObject] {
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
        print("Error!! The wrong file name or the file does not exist. NB! The file name should be without the extention.")
        return [:]
    }
}


    
    //    func extractItems(input: [String: AnyObject]) {
    //        if let items = extractData(input: input, using: "items") as? [AnyObject]  {
    //            for item in items {
    //                if let theItem = item as? [String : AnyObject] {
    //                    extractItemProperties(theItem)
    //                    //                    extractItems(input: theItem)
    //                }
    //            }
    //        }
    //    }
//}

