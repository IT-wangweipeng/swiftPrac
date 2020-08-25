//
//  BaseTabBarController.swift
//  youliao
//
//  Created by Apple on 2020/3/18.
//  Copyright © 2020 com.qujie.tech. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let tabbar = UITabBar.appearance()
        
        tabbar.tintColor = UIColor.red
        tabbar.barTintColor = UIColor.white
        tabbar.isTranslucent = true
        
        /// 添加子控制器
        addChildViewControllers()
    }
    
    /// 设置控制器
    private func setChildController(controller: UIViewController, imageName: String) {
        controller.tabBarItem.image = UIImage(named: imageName)
        controller.tabBarItem.selectedImage = UIImage(named: imageName + "_selected")
    }
    
    /// 添加子控制器
    private func addChildViewControllers() {
        setChildViewController(NewsPageViewController(), title: "有料", imageName: "icon_news")
        setChildViewController(VideoViewController(), title: "视频", imageName: "icon_video")
        setChildViewController(GamesViewController(), title: "夺宝", imageName: "icon_find")
        setChildViewController(assetsViewController(), title: "资产", imageName: "icon_profile")
    }
    
    /// 初始化子控制器
    private func setChildViewController(_ childController: UIViewController, title: String, imageName: String) {
        // 设置 tabbar 文字和图片
        setChildController(controller: childController, imageName: imageName)
        childController.title = title
        // 添加导航控制器为 TabBarController 的子控制器
        addChild(BaseNavigationController(rootViewController: childController))
    }
    
}
