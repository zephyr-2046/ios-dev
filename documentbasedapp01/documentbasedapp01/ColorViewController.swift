//
//  ColorViewController.swift
//  documentbasedapp01
//
//  Created by zephyr yang on 2019-06-25.
//  Copyright © 2019 zephyr yang. All rights reserved.
//

import Foundation
import UIKit

class ColorViewController: UIViewController {
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var colorPreview: UIView!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var documentNameLabel: UILabel!
    
    var colorDocument: ColorDocument?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.redSlider.maximumValue     = 255
        self.greenSlider.maximumValue   = 255
        self.blueSlider.maximumValue    = 255
    }
    
    @IBAction func slideDidChangeValue(_ sender: UISlider) {
        
        updateColorPreview(red: redSlider.value, green: greenSlider.value, blue: blueSlider.value)
    }
    
    func updateColorPreview( red: Float, green: Float, blue: Float) {
    
        self.colorLabel.text = String(format: "Red: %.1f, Green: %.1f, Blue: %.1f", red, green, blue)
        self.colorPreview.backgroundColor = UIColor(red: CGFloat(red / 255.0), green: CGFloat(green / 255.0), blue:CGFloat(blue / 255.0), alpha:1.0)
    }
    
    func configControllerUI() {
    
        self.documentNameLabel.text = self.colorDocument?.fileURL.lastPathComponent;
    
        if let colorModel = self.colorDocument?.colorModel {
    
            let redValue   = Float(colorModel.redValue)
            let greenValue = Float(colorModel.greenValue)
            let blueValue  = Float(colorModel.blueValue)
    
            self.redSlider.value   = redValue
            self.greenSlider.value = greenValue
            self.blueSlider.value  = blueValue
    
            self.updateColorPreview(red:redValue, green:greenValue, blue:blueValue)
        }
    }
    
    @IBAction func dismissController(_ sender: UIButton) {
        
        print( "self.dismiss() is called" )

        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveColorModel(_ sender: UIButton) {
    
        guard let colorDocument = self.colorDocument else {
            return
        }
        
        colorDocument.colorModel = ColorModel(redValue:Int(self.redSlider!.value),
                                              greenValue:Int(self.greenSlider!.value),
                                              blueValue:Int(self.blueSlider!.value))
        
        colorDocument.save(to: colorDocument.fileURL, for: UIDocument.SaveOperation.forOverwriting){
            
                (success: Bool) in
            
                if (success) {
            
                    print(" save to file : success")
            
                } else {
            
                    print(" save to file : fail")
                }
            }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        guard let colorDocument = self.colorDocument else {
            return
        }
        
        if colorDocument.documentState == UIDocument.State.normal {
            configControllerUI()
        }else{
            
            colorDocument.open(){
                (success: Bool) in
                
                if success {
                    self.configControllerUI()
                }else{
                    print("Error message open")
                }
            }
        }
    }
}
