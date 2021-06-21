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
    
    private var rof = RateOfInfusion(volume: 0.0, time: 0.0, speed: 0.0)
    let dropFirst = CALayer()
    let dropSecond = CALayer()
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    
    @objc private func didTapDone() {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        desingFunction()
        
        volumeLable.text = "mil"
        timeLable.text = "min"
        speedLable.text = "drops/sec"
        
        volumeTextField.text = nil
        timeTextField.text = nil
        speedTextField.text = nil
        
        volumeTextField.delegate = self
        timeTextField.delegate = self
        speedTextField.delegate = self
    }
    
    @IBAction func calculateButton(_ sender: Any) {
        view.endEditing(true)
        animateDropFirst()
        animateDropSecond()
        if rof.speed == 0.0 {
            speedTextField.text = String(format: "%.1f", rof.getSpeed)
        }
        else if rof.time == 0.0 {
            timeTextField.text = String(format: "%.0f", rof.getTime)
        }
        else if rof.volume == 0.0 {
            volumeTextField.text = String(format: "%.1f", rof.getVolume)
        }
        else {
            clearTextField()
        }
        print(rof.getSpeed)
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
// MARK: some func
extension RIViewController {
    func clearTextField() {
        volumeTextField.text = nil
        timeTextField.text = nil
        speedTextField.text = nil
    }
}
// MARK: animation
extension RIViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let objectSize: Double = 20
        
        dropFirst.backgroundColor = UIColor.systemBlue.cgColor
        dropFirst.frame = CGRect(x: Double((Double((view.frame.width))*0.15)-objectSize), y: Double(view.frame.height*0), width: objectSize, height: objectSize)
        view.layer.addSublayer(dropFirst)
        
        dropSecond.backgroundColor = UIColor.systemBlue.cgColor
        dropSecond.frame = CGRect(x: Double((view.frame.width)*0.85), y: Double(view.frame.height*0), width: objectSize, height: objectSize)
        view.layer.addSublayer(dropSecond)
        
        //animator = UIDynamicAnimator(referenceView: view)
        //gravity = UIGravityBehavior(items: <#T##[UIDynamicItem]#>)
        //animator.addBehavior(gravity)
    }
    
    @objc func animateDropFirst() {
        let animation = CABasicAnimation (keyPath: "position")
        animation.fromValue = CGPoint(x: dropFirst.frame.origin.x + (dropFirst.frame.size.width/2),
                                      y: dropFirst.frame.origin.y + (dropFirst.frame.size.height/2))
        animation.toValue = CGPoint(x: dropFirst.frame.origin.x + (dropFirst.frame.size.width/2),
                                    y: view.frame.height)
        animation.isRemovedOnCompletion = true
        animation.speed = 1.0
        animation.repeatDuration = 300000
        animation.repeatCount = 1
        dropFirst.add(animation, forKey: nil)
    }
    func animateDropSecond() {
        let animation = CABasicAnimation (keyPath: "position")
        animation.fromValue = CGPoint(x: dropSecond.frame.origin.x + (dropSecond.frame.size.width/2),
                                      y: dropSecond.frame.origin.y + (dropSecond.frame.size.height/2))
        animation.toValue = CGPoint(x: dropSecond.frame.origin.x + (dropSecond.frame.size.width/2),
                                    y: view.frame.height)
        animation.isRemovedOnCompletion = true
        animation.speed = 0.5
        animation.repeatDuration = 300000
        animation.repeatCount = 0
        dropSecond.add(animation, forKey: nil)
    }
    
}
// MARK: view desing
extension RIViewController {
    private func desingFunction() {
        calculateButton.layer.cornerRadius = 20
        volumeLable.layer.cornerRadius = 5
        volumeLable.layer.backgroundColor = CGColor(red: 0, green: 0, blue: 1, alpha: 0.1)
        timeLable.layer.backgroundColor = CGColor(red: 0, green: 0, blue: 1, alpha: 0.1)
        speedLable.layer.backgroundColor = CGColor(red: 0, green: 0, blue: 1, alpha: 0.1)
    }
}
