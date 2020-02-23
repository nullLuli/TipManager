//
//  UIViewController + Extension.swift
//  TipManager
//
//  Created by PXCM-0101-01-0045 on 2020/2/23.
//  Copyright © 2020 nullLuli. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    public static func topViewController(_ viewController: UIViewController? = nil) -> UIViewController?
    {
        let viewController = viewController ?? UIApplication.shared.windows.first?.rootViewController
        
        if let navigationController = viewController as? UINavigationController, !navigationController.viewControllers.isEmpty
        {
            return topViewController(navigationController.viewControllers.last)
        } else if let tabBarController = viewController as? UITabBarController,
            let selectedController = tabBarController.selectedViewController
        {
            return topViewController(selectedController)
        } else if let presentedController = viewController?.presentedViewController {
            return topViewController(presentedController)
        }
        
        return viewController
    }
}
