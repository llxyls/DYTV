//
//  NetworkTools.swift
//  DYTV
//
//  Created by liuqi on 16/10/12.
//  Copyright © 2016年 liuqi. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType{
    case get
    case post
}

class NetworkTools {
    class func requestData(type: MethodType, URLString: String, parameter: [String: Any]? = nil, finishcallback: @escaping (_ result: Any) -> ()) {
        
        let method = type == MethodType.get ? HTTPMethod.get : HTTPMethod.post
        
        Alamofire.request(URLString, method: method, parameters: parameter).responseJSON { (response) in
            
            guard response.result.value != nil else {
                print(response.result.value)
                return
            }
            
            finishcallback(response)
        }
        
        
    }
}
