//
//  RIViewController.swift
//  CDrop
//
//  Created by Иван Маришин on 19.06.2021.
//

import UIKit

class RIViewController: UIViewController {
    
    @IBOutlet weak var volumeTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var speedTextField: UITextField!
    
    private var rof = RateOfInfusion(volume: 0.0, time: 0, speed: 0.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        volumeTextField.text = String(rof.volume)
        timeTextField.text = String(rof.time)
        speedTextField.text = String(rof.speed)
        
        volumeTextField.delegate = self
        timeTextField.delegate = self
        speedTextField.delegate = self
    }
    
    @IBAction func calculateButton(_ sender: Any) {
        speedTextField.text = String(rof.getSpeed)
    }
}

extension RIViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        rof = RateOfInfusion(
            volume: Float(volumeTextField.text ?? "0.0") ?? 0.0,
            time: Int(timeTextField.text ?? "0") ?? 0,
            speed: Float(speedTextField.text ?? "0.0") ?? 0.0)
    }
}
