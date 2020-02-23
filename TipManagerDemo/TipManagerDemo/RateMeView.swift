//
//  RateMeView.swift
//  TipManagerDemo
//
//  Created by PXCM-0101-01-0045 on 2020/2/23.
//  Copyright © 2020 nullLuli. All rights reserved.
//

import Foundation
import UIKit

struct RateMeTip: TipType {
    var backImage: UIImage
    
    func show() -> Bool {
        let view = RateMeView(backImage: backImage)
        let window = UIApplication.shared.windows.first
        window?.addSubview(view)
        view.frame = window?.bounds ?? CGRect.zero
        window?.bringSubviewToFront(view)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            view.removeFromSuperview()
        }
        return true
    }
}

class RateMeView: BaseTipView {
    var imageView: UIImageView = UIImageView()
    
    required init(backImage: UIImage) {
        super.init(frame: CGRect.zero)
        
        addSubview(imageView)
        imageView.image = backImage
        
        backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 250),
            imageView.heightAnchor.constraint(equalToConstant: 161)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
