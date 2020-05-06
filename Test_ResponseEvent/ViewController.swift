//
//  ViewController.swift
//  Test_ResponseEvent
//
//  Created by Young Robine on 2020/4/26.
//  Copyright © 2020 Young Robine. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.addTarget(self, action: #selector(self.clickEvent1), for: .touchUpOutside)
        
        let tapRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(self.clickEvent2))
        button.addGestureRecognizer(tapRecognizer)
        
    }
    
    @objc func clickEvent1() -> Void {
        print("clickEvent1")
        
    }

    @objc func clickEvent2() -> Void {
        print("clickEvent2")
        
    }

}

