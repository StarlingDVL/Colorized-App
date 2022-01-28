//
//  ViewController.swift
//  Colorized App
//
//  Created by Юрий Скворцов on 10.01.2022.
//

import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: - IB Outlets

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
    
    // MARK: - Public properties
    var mainViewColor: UIColor!
    var delegate: SettingsViewControllerDelegate!
    
    // MARK: - Override functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doneButton.layer.cornerRadius = 15
        
        colorView.layer.cornerRadius = 15
        colorView.backgroundColor = mainViewColor
        
        setStartSliderValues()
        
        changeText(for: redValueLabel, greenValueLabel, blueValueLabel)
        changeText(for: redTextField, greenTextField, blueTextField)
        
    
    }
    
    // MARK: - IB Actions

    @IBAction func rgbSliderAction(_ sender: UISlider) {
        changeColor()
        
        switch sender {
        case redSlider:
            redValueLabel.text = string(from: redSlider)
            redTextField.text = string(from: redSlider)
        case greenSlider:
            greenValueLabel.text = string(from: greenSlider)
            greenTextField.text = string(from: greenSlider)
        default:
            blueValueLabel.text = string(from: blueSlider)
            blueTextField.text = string(from: blueSlider)
        }
    }

    @IBAction func doneButtonPressed() {
    }
    
    
    // MARK: - Private methods
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func changeColor() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    private func changeText(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redValueLabel:
                redValueLabel.text = string(from: redSlider)
            case greenValueLabel:
                greenValueLabel.text = string(from: greenSlider)
            default:
                blueValueLabel.text = string(from: blueSlider)
            }
        }
    }
    
    private func changeText(for textFields: UITextField...) {
        textFields.forEach { textField in
            switch textField {
            case redTextField:
                redTextField.text = string(from: redSlider)
            case greenTextField:
                greenTextField.text = string(from: greenSlider)
            default:
                blueTextField.text = string(from: blueSlider)
            }
        }
    }
    
    private func setStartSliderValues() {
        let rgbForSliders = CIColor(color: mainViewColor)
        
        redSlider.value = Float(rgbForSliders.red)
        greenSlider.value = Float(rgbForSliders.green)
        blueSlider.value = Float(rgbForSliders.blue)
    }
    
}

