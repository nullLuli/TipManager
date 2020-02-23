//
//  Notification.swift
//  TipManager
//
//  Created by PXCM-0101-01-0045 on 2020/2/22.
//  Copyright © 2020 nullLuli. All rights reserved.
//

import Foundation
extension Notification.Name {
    public static let DidDismissAlert = Notification.Name(rawValue: "com.TipManager.DidDismissAlert")  //用于dismiss一定在show后的情况
    public static let DidFailShowAlert = Notification.Name(rawValue: "com.TipManager.DidFailShowAlert")
}
