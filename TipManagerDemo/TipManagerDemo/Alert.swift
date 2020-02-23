//
//  Alert.swift
//  TipManagerDemo
//
//  Created by PXCM-0101-01-0045 on 2020/2/23.
//  Copyright © 2020 nullLuli. All rights reserved.
//

import Foundation
import UIKit

struct AlertTip: TipType {
    var title: String
    
    func show() -> Bool {
        if let topControl = UIViewController.topViewController() {
            let control = Alert(title: title)
            topControl.present(control, animated: true, completion: nil)
            return true
        }
        return false
    }
}

class Alert: BaseTipController {
    var contentView: UIView = UIView()
    var titleLabel: UILabel = UILabel()
    var tapGestrue: UITapGestureRecognizer?
    
    required init(title: String) {
        super.init(nibName: nil, bundle: nil)
        titleLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(contentView)
        contentView.addSubview(titleLabel)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentView.widthAnchor.constraint(equalToConstant: 300),
            contentView.heightAnchor.constraint(equalToConstant: 400)
        ])
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        contentView.backgroundColor = UIColor.white
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        tapGestrue = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        if let tapGestrue = tapGestrue {
            view.addGestureRecognizer(tapGestrue)
        }
    }
    
    @objc func tapAction() {
        dismiss(animated: true)
    }
}
