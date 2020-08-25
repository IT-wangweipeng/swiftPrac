//
//  MainTabController.swift
//  youliao
//
//  Created by Apple on 2020/3/17.
//  Copyright © 2020 com.qujie.tech. All rights reserved.
//

import UIKit

class MainTabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = UIColor.red
        tabBar.barTintColor = UIColor.white
        tabBar.isTranslucent = true

        //动态获取
        let path = Bundle.main.path(forResource: "MainVCSettings.json", ofType: nil)
        if let jsonPath = path {
            let jsonData = NSData(contentsOfFile: jsonPath)
            
            do{
                
                let dicArr = try JSONSerialization.jsonObject(with: jsonData! as Data, options:JSONSerialization.ReadingOptions.mutableContainers)
                print(dicArr)
                
                for dict in dicArr as! [[String:String]] {
                    addChild(childVCName: dict["vcName"]!, title: dict["title"]!, imageName: dict["imageName"]!)
                }
                
            }catch{
                
                addChild(childVCName: "NewsPageViewController", title: "有料", imageName: "icon_news")
                addChild(childVCName: "VideoViewController", title: "视频", imageName: "icon_video")
                addChild(childVCName: "GamesViewController", title: "寻宝", imageName: "icon_find")
                addChild(childVCName: "AssetsViewController", title: "资产", imageName: "icon_profile")
            }
        }
    }
    

    private func addChild(childVCName:String,title:String,imageName:String){
        
        //获取命名空间
        let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as!String
        print(nameSpace)
        //字符串转类
        let cls:AnyClass? = NSClassFromString(nameSpace + "." + childVCName)
        let vcCls = cls as!UIViewController.Type
        let vc = vcCls.init()

        vc.tabBarItem.image = UIImage(named: imageName)!.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.selectedImage = UIImage(named: imageName + "_selected")
        vc.title = title

        let nav = UINavigationController()
        nav.addChild(vc)
        
        addChild(nav)
        
        
    }
    

}
