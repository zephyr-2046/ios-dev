//
//  ColorModel.swift
//  documentbasedapp01
//
//  Created by zephyr yang on 2019-06-24.
//  Copyright © 2019 zephyr yang. All rights reserved.
//

import Foundation

class ColorModel {
    
    var redValue : Int
    var greenValue : Int
    var blueValue : Int
    
    init(redValue: Int, greenValue: Int, blueValue: Int){
        self.redValue = redValue
        self.greenValue = greenValue
        self.blueValue = blueValue
    }
    
    func lighter(component: Int, toAdd: Int) ->Int {
        return min(component + toAdd, 255);
    }
    
    func lighterColor(toAdd: Int) -> ColorModel {
    
        let redValue   = self.lighter(component: self.redValue, toAdd:toAdd)
        let greenValue = self.lighter(component: self.greenValue, toAdd:toAdd)
        let blueValue  = self.lighter(component: self.blueValue, toAdd:toAdd)
    
        return ColorModel.init(redValue: redValue, greenValue: greenValue, blueValue: blueValue)
    }
}
