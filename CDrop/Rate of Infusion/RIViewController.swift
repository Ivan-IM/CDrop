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
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    
    @objc private func didTapDone() {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        desingFunction()
        
        volumeTextField.text = nil
        timeTextField.text = nil
        speedTextField.text = nil
        
        volumeTextField.delegate = self
        timeTextField.delegate = self
        speedTextField.delegate = self
    }
    
    @IBAction func calculateButton(_ sender: Any) {
        view.endEditing(true)
//        let timer = Timer.scheduledTimer(withTimeInterval: Double(0.3), repeats: true) { Timer in
//            self.drawAnimateDrop()
//        }
        
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
        }
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
    func clearTextField() {
        volumeTextField.text = nil
        timeTextField.text = nil
        speedTextField.text = nil
    }
}

// MARK: view desing
extension RIViewController {
    private func desingFunction() {
        dropImageFirst.image = UIImage(named: "drop")
        dropImageFirst.layer.shadowRadius = 1.0
        dropImageFirst.layer.shadowOpacity = 0.5
        dropImageFirst.layer.shadowOffset = CGSize(width: 3, height: 3)
        
        dropImageSecond.image = UIImage(named: "drop")
        dropImageSecond.layer.shadowRadius = 1.0
        dropImageSecond.layer.shadowOpacity = 0.5
        dropImageSecond.layer.shadowOffset = CGSize(width: 3, height: 3)
        
        calculateButton.layer.cornerRadius = 20
        calculateButton.layer.shadowRadius = 3.0
        calculateButton.layer.shadowOpacity = 0.5
        calculateButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        
        volumeTextField.layer.shadowRadius = 3.0
        volumeTextField.layer.shadowOpacity = 0.5
        volumeTextField.layer.shadowOffset = CGSize(width: 3, height: 3)
        
        timeTextField.layer.shadowRadius = 3.0
        timeTextField.layer.shadowOpacity = 0.5
        timeTextField.layer.shadowOffset = CGSize(width: 3, height: 3)
        
        speedTextField.layer.shadowRadius = 3.0
        speedTextField.layer.shadowOpacity = 0.5
        speedTextField.layer.shadowOffset = CGSize(width: 3, height: 3)
        
        volumeLable.text = " ml"
        volumeLable.layer.cornerRadius = 5
        volumeLable.layer.backgroundColor = CGColor(red: 0, green: 0, blue: 1, alpha: 1)
        volumeLable.layer.shadowRadius = 3.0
        volumeLable.layer.shadowOpacity = 0.5
        volumeLable.layer.shadowOffset = CGSize(width: 3, height: 3)
        
        timeLable.text = " min"
        timeLable.layer.cornerRadius = 5
        timeLable.layer.backgroundColor = CGColor(red: 0, green: 0, blue: 1, alpha: 1)
        timeLable.layer.shadowRadius = 3.0
        timeLable.layer.shadowOpacity = 0.5
        timeLable.layer.shadowOffset = CGSize(width: 3, height: 3)
        
        speedLable.text = " drops/sec"
        speedLable.layer.cornerRadius = 5
        speedLable.layer.backgroundColor = CGColor(red: 0, green: 0, blue: 1, alpha: 1)
        speedLable.layer.shadowRadius = 3.0
        speedLable.layer.shadowOpacity = 0.5
        speedLable.layer.shadowOffset = CGSize(width: 3, height: 3)
    }
}

extension RIViewController {
    private func drawAnimateDrop() {
        let dropFirst = UIImageView(frame: CGRect(x: CGFloat(dropImageFirst.frame.origin.x), y: CGFloat(dropImageFirst.frame.origin.y), width: CGFloat(dropImageFirst.frame.width), height: CGFloat(dropImageFirst.frame.height)))
        let dropSecond = UIImageView(frame: CGRect(x: CGFloat(dropImageSecond.frame.origin.x), y: CGFloat(dropImageSecond.frame.origin.y), width: CGFloat(dropImageSecond.frame.width), height: CGFloat(dropImageSecond.frame.height)))
        dropFirst.image = UIImage(named: "drop")
        dropSecond.image = UIImage(named: "drop")
        animator = UIDynamicAnimator(referenceView: view)
        gravity = UIGravityBehavior(items: [dropFirst, dropSecond])
        gravity.magnitude = 9
        view.addSubview(dropFirst)
        view.addSubview(dropSecond)
        animator.addBehavior(gravity)
    }
}
