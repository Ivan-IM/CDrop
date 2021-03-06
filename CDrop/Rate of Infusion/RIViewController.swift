//
//  RIViewController.swift
//  CDrop
//
//  Created by Иван Маришин on 19.06.2021.
//

import UIKit

class RIViewController: UIViewController {
    
    @IBOutlet weak var volumeLable: UILabel!
    @IBOutlet weak var timeLable: UILabel!
    @IBOutlet weak var speedLable: UILabel!
    @IBOutlet weak var volumeTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var speedTextField: UITextField!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var dropImageFirst: UIImageView!
    @IBOutlet weak var dropImageSecond: UIImageView!
    
    private var rof = RateOfInfusion(volume: 0.0, time: 0.0, speed: 0.0)
    var timer: Timer?
    
    @objc private func didTapDone() {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        desingFunction()
        
        volumeTextField.delegate = self
        timeTextField.delegate = self
        speedTextField.delegate = self
    }
    
    @IBAction func calculateButton(_ sender: Any) {
        view.endEditing(true)
        if rof.speed == 0.0 {
            rof.speed = rof.getSpeed
            speedTextField.text = String(format: "%.1f", rof.speed)
        }
        else if rof.time == 0.0 {
            rof.time = rof.getTime
            timeTextField.text = String(format: "%.0f", rof.time)
        }
        else if rof.volume == 0.0 {
            rof.volume = rof.getVolume
            volumeTextField.text = String(format: "%.1f", rof.volume)
        }
        else {
            clearTextField()
            stopTimer()
        }
        startTimer()
    }
}

// MARK: delegate
extension RIViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        rof = RateOfInfusion(
            volume: Float(volumeTextField.text ?? "0.0") ?? 0.0,
            time: Float(timeTextField.text ?? "0.0") ?? 0.0,
            speed: Float(speedTextField.text ?? "0.0") ?? 0.0)
    }
}

// MARK: keyboard
extension RIViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let keyboardToolbar = UIToolbar()
        textField.inputAccessoryView = keyboardToolbar
        keyboardToolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(
            title:"Done",
            style: .done,
            target: self,
            action: #selector(didTapDone)
        )
        
        let flexBarButton = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        keyboardToolbar.items = [flexBarButton, doneButton]
    }
}

// MARK: cell clear func
extension RIViewController {
    private func clearTextField() {
        rof.volume = 0.0
        rof.time = 0.0
        rof.speed = 0.0
        volumeTextField.text = nil
        timeTextField.text = nil
        speedTextField.text = nil
    }
}

// MARK: view desing
extension RIViewController {
    private func desingFunction() {
        calculateButton.layer.cornerRadius = 20
        calculateButton.layer.backgroundColor = CGColor(red: 0, green: 0, blue: 1, alpha: 1)
        calculateButton.layer.shadowRadius = 3.0
        calculateButton.layer.shadowOpacity = 0.5
        calculateButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        
        volumeTextField.text = nil
        timeTextField.text = nil
        speedTextField.text = nil
        textFieldDesing(someView: [volumeTextField, timeTextField, speedTextField])
        
        volumeLable.text = " ml"
        timeLable.text = " min"
        speedLable.text = " drops/sec"
        lableDesing(someView: [volumeLable, timeLable, speedLable])
    }
    
    private func lableDesing(someView: [UIView]) {
        for i in someView {
            i.layer.cornerRadius = 5
            i.layer.backgroundColor = CGColor(red: 0, green: 0, blue: 1, alpha: 1)
            i.layer.shadowRadius = 3.0
            i.layer.shadowOpacity = 0.5
            i.layer.shadowOffset = CGSize(width: 3, height: 3)
        }
    }
    
    private func textFieldDesing(someView: [UIView]) {
        for i in someView {
            i.layer.shadowRadius = 3.0
            i.layer.shadowOpacity = 0.5
            i.layer.shadowOffset = CGSize(width: 3, height: 3)
        }
    }
}

// MARK: timer func
extension RIViewController {
    private func startTimer() {
        timer?.invalidate()
        let interval = 1/Double(rof.speed)
        print(interval)
        if interval > 0 {
            timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { (timer) in
                BezierDrop.drawDrop(view: self.view)
            }
        }
        else {
            timer?.invalidate()
        }
    }
    private func stopTimer() {
        timer?.invalidate()
    }
}

