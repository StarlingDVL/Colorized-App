//
//  ViewController.swift
//  Colorized App
//
//  Created by Юрий Скворцов on 10.01.2022.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redValueLabel: UILabel!
    @IBOutlet var greenValueLabel: UILabel!
    @IBOutlet var blueValueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    @IBOutlet var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doneButton.layer.cornerRadius = 10
        
        changeColor()
        changeLabelText()
    }

    @IBAction func rgbSliderAction(_ sender: UISlider) {
        changeColor()
        
        changeLabelText()
    }

    @IBAction func doneButtonPressed() {
    }
    
    private func changeColor() {
        colorView.backgroundColor = UIColor(red: CGFloat(redSlider.value),
                                            green: CGFloat(greenSlider.value),
                                            blue: CGFloat(blueSlider.value),
                                            alpha: 1)
    }
    
    private func changeLabelText() {
        redValueLabel.text = String(format: "%.2f", redSlider.value)
        greenValueLabel.text = String(format: "%.2f", greenSlider.value)
        blueValueLabel.text = String(format: "%.2f", blueSlider.value)
    }
}
