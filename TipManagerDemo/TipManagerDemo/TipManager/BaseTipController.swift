//
//  BaseTipViewController.swift
//  Client
//
//  Created by nullLuli on 2018/8/8.
//  Copyright © 2018年 36Kr. All rights reserved.
//
import UIKit

open class BaseTipController: UIViewController{    
    deinit {
        #if DEBUG
        TipManager.manager.timer?.invalidate()
        TipManager.manager.timer = nil
        #endif
        
        NotificationCenter.default.post(name: .DidDismissAlert, object: nil)
    }
                
    override open func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: completion)
        #if DEBUG
        if !(TipManager.manager.timer != nil) { //同一个弹框可能会产生多个dismiss，以第一个dimiss时间为准
            TipManager.manager.timer = Timer.scheduledTimer(timeInterval: 2, target: TipManager.manager, selector: #selector(TipManager.notInvalidTimerInTime), userInfo: nil, repeats: false)
        }
        #endif
    }
}
