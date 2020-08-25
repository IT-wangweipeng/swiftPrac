//
//  NetworkManager.swift
//  youliao
//
//  Created by Apple on 2020/3/19.
//  Copyright © 2020 com.qujie.tech. All rights reserved.
//

import Foundation
import Moya
import Alamofire
import SwiftyJSON

//超时时长 单位s
private var requestTimeOut:Double = 30

//成功回调
typealias successCallback = ((String) -> (Void))

//失败回掉
typealias failedCallback = ((String) -> (Void))

//网络错误的回调
typealias errorCallback = (() -> (Void))

///基本设置
private let myEndpointClosure = { (target: NetServiceApis) -> Endpoint in
    
    let url = target.baseURL.absoluteString + target.path
    var task = target.task
    
    /*
         需要在每个请求中都添加类似token参数的时候可使用下面代码
         */
    //    let additionalParameters = ["token":"888888"]
    //    let defaultEncoding = URLEncoding.default
    //    switch target.task {
    //        ///在你需要添加的请求方式中做修改就行，不用的case 可以删掉。。
    //    case .requestPlain:
    //        task = .requestParameters(parameters: additionalParameters, encoding: defaultEncoding)
    //    case .requestParameters(var parameters, let encoding):
    //        additionalParameters.forEach { parameters[$0.key] = $0.value }
    //        task = .requestParameters(parameters: parameters, encoding: encoding)
    //    default:
    //        break
    //    }
    
    
    var endpoint = Endpoint(
        url: url,
        sampleResponseClosure:{.networkResponse(200, target.sampleData)},
        method: target.method,
        task: task,
        httpHeaderFields: target.headers
    )
    requestTimeOut = 30 // 也可每个接口单独设置超时时长
    switch target {
    case .newsList:
        return endpoint
        
    case .videoList:
        requestTimeOut = 8 //此接口8s超时
        return endpoint
        
    default:
        return endpoint
    }
    
}

///网络请求的设置
private let requestClosure = { (endpoint: Endpoint, done: MoyaProvider.RequestResultClosure) in
    do {
        var request = try endpoint.urlRequest()
        //设置请求时长
        request.timeoutInterval = requestTimeOut
        // 打印请求参数
        if let requestData = request.httpBody {
            
            
            print("\(request.url!)"+"\n"+"\(request.httpMethod ?? "")"+"发送参数"+"\(String(data: request.httpBody!, encoding: String.Encoding.utf8) ?? "")")
            
        } else {
            
            
            print("\(request.url!)"+"\(String(describing: request.httpMethod))")
            
        }
        done(.success(request))
        
    } catch {
        done(.failure(MoyaError.underlying(error, nil)))
    }
}


/// NetworkActivityPlugin插件用来监听网络请求，界面上做相应的展示  也可在相应地方做响应
private let networkPlugin = NetworkActivityPlugin.init { (changeType, targetType) in
    
    print("networkPlugin \(changeType)")
    
    //targetType 是当前请求的基本信息
    switch(changeType){
    case .began:
        print("开始请求网络")
        
    case .ended:
        print("结束")
    }
}

///创建网络请求对象
let Provider = MoyaProvider<NetServiceApis>(endpointClosure: myEndpointClosure, requestClosure: requestClosure, plugins: [networkPlugin], trackInflights: false)

///只需知道结果--(可以给调用的NetWorkReques方法的写参数默认值达到一样的效果,这里为解释方便做抽出来二次封装)
///
/// - Parameters:
///   - target: 网络请求
///   - completion: 请求成功的回调
func NetWorkRequest(_ target: NetServiceApis, completion: @escaping successCallback){
    NetWorkRequest(target, completion: completion, failed: nil, errorResult: nil)
}


/// 需要知道成功或者失败的网络请求， 要知道code码等 (可以给调用的NetWorkRequest方法的参数默认值达到一样的效果,这里为解释方便做抽出来二次封装)
///
/// - Parameters:
///   - target: 网络请求
///   - completion: 成功的回调
///   - failed: 请求失败的回调
func NetWorkRequest(_ target: NetServiceApis, completion: @escaping successCallback , failed:failedCallback?) {
    NetWorkRequest(target, completion: completion, failed: failed, errorResult: nil)
}


///  需要知道成功、失败、错误情况回调的网络请求   像结束下拉刷新各种情况都要判断
///
/// - Parameters:
///   - target: 网络请求
///   - completion: 成功
///   - failed: 失败
///   - error: 错误
@discardableResult //当需要主动取消网络请求的时候可以用返回值Cancellable, 一般不用的话做忽略处理
func NetWorkRequest(_ target: NetServiceApis, completion: @escaping successCallback , failed:failedCallback?, errorResult:errorCallback?) -> Cancellable? {
    //先判断网络是否有链接 没有的话直接返回--代码略
    if !isNetworkConnect{
        print("提示用户网络似乎出现了问题")
        return nil
    }
    //这里显示loading图
    return Provider.request(target) { (result) in
        //隐藏hud
        switch result {
        case let .success(response):
            
            do {
                
                let jsonData = try JSON(data: response.data)
                print(jsonData)
                //               这里的completion和failed判断条件依据不同项目来做，为演示demo我把判断条件注释了，直接返回completion。
                
                completion(String(data: response.data, encoding: String.Encoding.utf8)!)
                
                print("code不为成功值 后台返回message"+"\(jsonData["message"].stringValue)")
                
                //                if jsonData["code"].stringValue == "200"{ //需根据实际情况做判断
                //                    completion(String(data: response.data, encoding: String.Encoding.utf8)!)
                //                }else{
                //                    failed?(String(data: response.data, encoding: String.Encoding.utf8)!)
                //                }
                
            } catch {
            }
        case let .failure(error):
            //网络连接失败，提示用户
            print("网络连接失败\(error)")
            errorResult?()
        }
    }
}
