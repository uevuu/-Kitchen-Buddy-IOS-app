//
//  UITabBarController+Extensions.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 28.04.2023.
//

import UIKit

extension UITabBarController {
    func addViewController(viewController: UIViewController, title: String, image: UIImage?) {
        viewController.title = title
        viewController.tabBarItem.image = image
        var viewControllers = self.viewControllers ?? []
        viewControllers.append(viewController)
        setViewControllers(viewControllers, animated: true)
    }
}
