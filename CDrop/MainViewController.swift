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
        navigationController?.navigationBar.barTintColor = .systemBlue
        navigationController?.navigationBar.tintColor = .white
        
        roiButton.layer.cornerRadius = 20
        roiButton.layer.shadowRadius = 3.0
        roiButton.layer.shadowOpacity = 0.5
        roiButton.layer.shadowOffset = CGSize(width: 5, height: 5)
    }


}

