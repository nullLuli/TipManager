//
//  BaseTipView.swift
//  Client
//
//  Created by nullLuli on 2018/8/8.
//  Copyright © 2018年 36Kr. All rights reserved.
//
import UIKit

class BaseTipView: UIView {
    deinit {
        #if DEBUG
        TipManager.manager.timer?.invalidate()
        TipManager.manager.timer = nil
        #endif

        NotificationCenter.default.post(name: .DidDismissAlert, object: nil)
    }
        
    override func removeFromSuperview() {
        super.removeFromSuperview()
        
        #if DEBUG
        if !(TipManager.manager.timer != nil) { //同一个弹框可能会产生多个removeFromSuperview，以第一个removeFromSuperview时间为准
            TipManager.manager.timer = Timer.scheduledTimer(timeInterval: 2, target: TipManager.manager, selector: #selector(TipManager.notInvalidTimerInTime), userInfo: nil, repeats: false)
        }
        #endif
    }
}
