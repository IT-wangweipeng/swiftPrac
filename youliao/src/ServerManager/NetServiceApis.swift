//
//  NetServiceApis.swift
//  youliao
//
//  Created by Apple on 2020/3/19.
//  Copyright © 2020 com.qujie.tech. All rights reserved.
//

import Foundation

/// 接口定义名称部分 要求对所需参数进行注释

enum NetServiceApis {
    
    //eg
    /// 视频列表
    //params:
    //email:用户邮箱  password:用户密码
    case videoList(email:String,password:String)
    /// 新闻列表
    case newsList(parameters:[String:Any])
}
