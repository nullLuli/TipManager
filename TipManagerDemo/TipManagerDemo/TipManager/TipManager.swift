//
//  TipManager.swift
//  TipManager
//
//  Created by PXCM-0101-01-0045 on 2020/2/22.
//  Copyright © 2020 nullLuli. All rights reserved.
//

import Foundation

public protocol TipType {
    func show() -> Bool
}

public class TipManager: NSObject {

    private var tipQueue: [TipType] = []
    private var isShow: Bool = false
    private var stop: Bool = false {
        didSet{
            if !stop && !isShow {
                showNextTip()
            }
        }
    }
    private let lock = NSLock()
    
    #if DEBUG
    var timer: Timer?
    #endif
    
    static var manager: TipManager = TipManager()
    
    override init() {
        super.init()
        //注册通知
        
        NotificationCenter.default.addObserver(self, selector: #selector(dismiss(notification:)), name: .DidDismissAlert, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(failShow(notification:)), name: .DidFailShowAlert, object: nil)
    }
    
    public class func show(_ tip: TipType) {
        if !Thread.isMainThread {
            DispatchQueue.main.async {
                TipManager.show(tip)
            }
            return
        }
        let manager = TipManager.manager
        manager.lock.lock()
        manager.add(tip)
        manager.lock.unlock()
    }
    
    public class func applicationDidBecomeActive() {
        TipManager.manager.stop = false
    }
    
    public class func applicationWillResignActive() {
        TipManager.manager.stop = true
    }
    
    private func add(_ tip: TipType) {
        tipQueue.append(tip)
        //检查
        if !isShow {
            showNextTip()
            return
        }
    }
    
    private func showNextTip() {
        if stop {
            isShow = false
            return
        }
        
        if let tip = tipQueue.first {
            let showSuccess = tip.show()
            if !showSuccess {
                self.tipQueue.remove(at: 0)
                self.showNextTip()
            } else {
                self.isShow = true
            }
        } else {
            isShow = false
        }
    }
    
    @objc private func failShow(notification: NSNotification) {
        lock.lock()
        if tipQueue.count > 0 {
            tipQueue.remove(at: 0)
        }
        showNextTip()
        lock.unlock()
    }

    @objc private func dismiss(notification: NSNotification) {
        //可以优化成按照ID来删除tip
        lock.lock()
        if tipQueue.count > 0 {
            tipQueue.remove(at: 0)
        }
        showNextTip()
        lock.unlock()
    }
    
    @objc func notInvalidTimerInTime() {
        //BaseTipController / BaseTipView 没有及时释放时调用，仅在debug环境使用
        assertionFailure("tip dismiss或者removeFromSuperview后没有被及时释放，会阻塞后面的弹框弹出，需要检查一下该弹框")
    }
}
