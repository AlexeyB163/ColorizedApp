//
//  ColorScreenViewController.swift
//  HW 2
//
//  Created by User on 25.01.2022.
//

import UIKit
protocol ColorScreenDelegate {
    
    func setSlidersVolueForSettingVC(for sliders: UISlider...)
    func setColorForFirstScreen (with funcSetColor: () -> UIColor)
}

class ColorScreenViewController: UIViewController {
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingVC = segue.destination as? SettingsViewController else { return }
        settingVC.delegate = self
    }
}

extension ColorScreenViewController: ColorScreenDelegate {
    
    func setColorForFirstScreen(with funcSetColor: () -> UIColor) {
        view.backgroundColor = funcSetColor()
    }
    func setSlidersVolueForSettingVC(for sliders: UISlider...) {
       let colorView = view.backgroundColor
       
       for slider in sliders {
           if slider.tag == 0 {
               slider.value = Float((colorView?.rgba.red)!)
           } else if slider.tag == 1 {
               slider.value = Float((colorView?.rgba.green)!)
           } else {
               slider.value = Float((colorView?.rgba.blue)!)
           }
       }
   }
}

extension UIColor {
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
    
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        return (r, g, b, a)
        }
}
