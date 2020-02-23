//
//  ViewController.swift
//  TipManagerDemo
//
//  Created by PXCM-0101-01-0045 on 2020/2/10.
//  Copyright © 2020 nullLuli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor.white
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        TipManager.show(AlertTip(title: "请绑定手机号"))
        if let image = UIImage(named: "rate") {
            TipManager.show(RateMeTip(backImage: image))
        }
        TipManager.show(AlertTip(title: "请绑定手机号"))
    }
}

