//
//  NetServiceApis+Extension.swift
//  youliao
//
//  Created by Apple on 2020/3/19.
//  Copyright © 2020 com.qujie.tech. All rights reserved.
//

import Foundation
import Moya

extension NetServiceApis:TargetType {
    
    //域名 可根据不同情况判断
    var baseURL: URL {
        return URL.init(string: "http://news-at.zhihu.com/api/")!
    }
        
    //各接口具体路径
    var path: String {
        switch self {
        case .newsList:
            return "/news"
        case .videoList:
            return "/video"
        }
    }
    
    //请求方式 get || post
    var method: Moya.Method {
        switch self {
        case .newsList:
            return .get
        default:
            return .post
        }
    }
    
    //仅单元测试
    var sampleData: Data {
         return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        switch self {
            
        case let .newsList(parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
            
        case let .videoList(email, password):
            
            let param = ["email":email,"password":password]
            return .requestCompositeData(bodyData: Data(), urlParameters: param)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type":"application/x-www-form-urlencoded"]
    }
}


//MARK: - tool method
private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}

extension Task {
    static func json(_ parameters: [String: Any]) -> Task {
        return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
    }
}
