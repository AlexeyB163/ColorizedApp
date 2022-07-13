//
//  SettingsViewController.swift
//  HW 2
//
//  Created by User on 28.01.2022.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var colorView: UIView!

    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
     @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var redTextField: UITextField!
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var blueTextField: UITextField!
    
    var delegate:ColorScreenDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate.setSlidersVolueForSettingVC(for: redSlider, greenSlider, blueSlider)
        setColor()
        setValue(for: redLabel, greenLabel, blueLabel)
        addButtonDoneOnKeyboard()
        
        colorView.layer.cornerRadius = 15
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
    }
    
    @IBAction func rgbSlider(_ sender: UISlider) {
        setColor()
        switch sender {
        case redSlider:
            redLabel.text = string(from: redSlider)
            redTextField.text = string(from: redSlider)
        case greenSlider:
            greenLabel.text = string(from: greenSlider)
            greenTextField.text = string(from: greenSlider)
        default:
            blueLabel.text = string(from: blueSlider)
            blueTextField.text = string(from: blueSlider)
        }
    }
    
    @IBAction func doneActionButton() {
        delegate.setColorForFirstScreen(with: setColor)
        dismiss(animated: true)
    }
    
    private func setColor() -> UIColor{
        let color = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
        colorView.backgroundColor = color
        return color
    }
    
    private func setValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redLabel:
                redLabel.text = string(from: redSlider)
                redTextField.text = string(from: redSlider)
            case greenLabel:
                greenLabel.text = string(from: greenSlider)
                greenTextField.text = string(from: greenSlider)
            default:
                blueLabel.text = string(from: blueSlider)
                blueTextField.text = string(from: blueSlider)
                
            }
        }
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
}

extension SettingsViewController: UITextFieldDelegate {
   
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let newValue = textField.text else { return }
        guard let numberValue = Float(newValue) else { return }
        
        if textField == redTextField {
            redSlider.value = numberValue
            redLabel.text = String(numberValue)
            setColor()
            greenTextField.becomeFirstResponder()
        
        } else if textField == greenTextField {
            greenSlider.value = numberValue
            greenLabel.text = String(numberValue)
            setColor()
            blueTextField.becomeFirstResponder()
        } else {
            blueSlider.value = numberValue
            blueLabel.text = String(numberValue)
            setColor()
            blueTextField.resignFirstResponder()
        }
    }
}

extension SettingsViewController {
    
    @objc private func doneClick() {
        view.endEditing(false)
    }
    
    func addButtonDoneOnKeyboard() {
        let keyboardToolBar = UIToolbar()
        keyboardToolBar.sizeToFit()

        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneClick))
        keyboardToolBar.setItems([flexBarButton, doneBarButton], animated: false)

        redTextField.inputAccessoryView = keyboardToolBar
        greenTextField.inputAccessoryView = keyboardToolBar
        blueTextField.inputAccessoryView = keyboardToolBar
    }
    
}
