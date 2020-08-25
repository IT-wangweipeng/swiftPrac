//
//  NetworkCondition.swift
//  youliao
//
//  Created by Apple on 2020/3/19.
//  Copyright © 2020 com.qujie.tech. All rights reserved.
//

import Foundation
import Alamofire

///获取运营商网络、wifi、是否连接网络等


///判断是否联网
var isNetworkConnect: Bool {
    get{
        let network = NetworkReachabilityManager()
        return network?.isReachable ?? true //无返回就默认网络已连接
    }
}
