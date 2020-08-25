//
//  Const.swift
//  youliao
//
//  Created by Apple on 2020/3/18.
//  Copyright © 2020 com.qujie.tech. All rights reserved.
//

import Foundation
import UIKit

/**
 此文件定义全局通用常量，比如：屏幕适配、手机机型判断、通用字体大小、通用颜色等
 */

/**
 屏幕适配
 */

//状态栏高度 全面屏44pt 非全面屏20pt
let STATUSBARHEIGHT = UIApplication.shared.statusBarFrame.height

let SCREENWIDTH = UIScreen.main.bounds.width
let SCREENHEIGHT = UIScreen.main.bounds.height

//导航栏高度
let navigationHeight = (STATUSBARHEIGHT + 44)

//tabbar高度
let tabBarHeight = (STATUSBARHEIGHT == 44 ? 83 : 49)

//顶部安全距离
let topSafeAreaHeight = (STATUSBARHEIGHT - 20)

//底部安全距离
let bottomSafeAreaHeight = (tabBarHeight - 49)

/**
 机型判断
 */
public extension UIDevice {
    
    var modelName: String {
        
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {

            case "iPhone3,1", "iPhone3,2", "iPhone3,3":  return "iPhone4"
            case "iPhone4,1":  return "iPhone4s"
            case "iPhone5,1":  return "iPhone5"
            case "iPhone5,2":  return "iPhone5"
            case "iPhone5,3", "iPhone5,4":  return "iPhone5c"
            case "iPhone6,1", "iPhone6,2":  return "iPhone5s"
            case "iPhone7,2":  return "iPhone6"
            case "iPhone7,1":  return "iPhone6Plus"
            case "iPhone8,1":  return "iPhone6s"
            case "iPhone8,2":  return "iPhone6sPlus"
            case "iPhone8,4":  return "iPhoneSE"
            case "iPhone9,1", "iPhone9,3":  return "iPhone7"
            case "iPhone9,2", "iPhone9,4":  return "iPhone7Plus"
            case "iPhone10,1", "iPhone10,4": return "iPhone8"
            case "iPhone10,2", "iPhone10,5": return "iPhone8Plus"
            case "iPhone10,3", "iPhone10,6": return "iPhoneX"
            case "iPhone11,8":  return "iPhoneXR"
            case "iPhone11,2":  return "iPhoneXS"
            case "iPhone11,4", "iPhone11,6": return "iPhoneXSMax"
            
            case "i386", "x86_64":  return "Simulator"
            
        default:  return identifier
        }
    }
}



/**
 文字字体大小
 */


/**
 通用颜色
 */
