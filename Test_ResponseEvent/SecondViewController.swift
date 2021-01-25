//
//  SecondViewController.swift
//  Test_ResponseEvent
//
//  Created by Young Robine on 2020/5/9.
//  Copyright © 2020 Young Robine. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func clickButtonEvent(_ sender: Any) {
        MainManagar.shared.targetColor = .black;
        
    }
}
