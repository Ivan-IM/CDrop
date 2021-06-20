//
//  ViewController.swift
//  CDrop
//
//  Created by Иван Маришин on 19.06.2021.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var roiButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roiButton.layer.cornerRadius = 20
    }


}

