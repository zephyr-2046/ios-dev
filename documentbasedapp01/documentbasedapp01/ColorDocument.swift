//
//  Document.swift
//  documentbasedapp01
//
//  Created by zephyr yang on 2019-06-24.
//  Copyright © 2019 zephyr yang. All rights reserved.
//

import UIKit

class ColorDocument: UIDocument {
    
    var colorModel: ColorModel?
    
    override func contents(forType typeName: String) throws -> Any {
        // Encode your document with an instance of NSData or NSFileWrapper
        
        print("Z contents -- typeName -- \(typeName)")
        return Data()
    }
    
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        // Load your document from contents
        print("Z contents -- load -- " + (typeName ?? "empty"))

        let colorText: String? = String(data: contents as! Data, encoding: String.Encoding.utf8)?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        guard colorText != nil else {return}
        
        print("Z contents -- colorText -- \(colorText) -- \(colorText!.count)")

        if (colorText!.count > 0) {
            
            let colorValues: [String] = colorText!.components(separatedBy: ",")
            
            guard let redValue   = Int(colorValues[0]),
            let greenValue = Int(colorValues[1]),
            let blueValue  = Int(colorValues[2]) else {return}

            print("Z contents -- colorText[0] -- \(redValue)")

            print("Z contents -- colorText[1] -- \(greenValue)")

            print("Z contents -- colorText[2] -- \(blueValue)")

            self.colorModel = ColorModel(redValue: redValue, greenValue: greenValue, blueValue: blueValue)
            
            print("Z contents -- self.colorModel -- \(self.colorModel)")

            
        } else {
            
            NSLog("文件格式错误");
        }

    }
}

