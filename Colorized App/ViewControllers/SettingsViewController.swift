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
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
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
            changeText(for: redValueLabel)
            changeText(for: redTextField)
        case greenSlider:
            changeText(for: greenValueLabel)
            changeText(for: greenTextField)
        default:
            changeText(for: blueValueLabel)
            changeText(for: blueTextField)
        }
    }

    @IBAction func doneButtonPressed() {
        delegate.setColor(colorView.backgroundColor ?? .magenta)
        dismiss(animated: true)
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
extension SettingsViewController {
    
    private func showAlert(title: String, message: String, textField: UITextField) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { okAction in
            self.changeText(for: textField)
            }
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

extension SettingsViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textFieldDidEndEditing(textField)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        if let newSliderValue = Float(text) {
            if newSliderValue >= 0 && newSliderValue <= 1 {
                switch textField {
                case redTextField:
                    redSlider.setValue(newSliderValue, animated: true)
                    changeText(for: redValueLabel)
                case greenTextField:
                    greenSlider.setValue(newSliderValue, animated: true)
                    changeText(for: greenValueLabel)
                default:
                    blueSlider.setValue(newSliderValue, animated: true)
                    changeText(for: blueValueLabel)
                }
            } else {
                showAlert(title: "Wrong value!", message: "Enter a number from 0 to 1", textField: textField)
            }
            changeColor()
            return
        }
        showAlert(title: "Wrong format!", message: "Please enter correct value", textField: textField)
    }
}
