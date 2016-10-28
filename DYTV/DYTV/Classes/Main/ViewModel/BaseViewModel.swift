//
//  BaseViewModel.swift
//  DYTV
//
//  Created by liuqi on 16/10/28.
//  Copyright © 2016年 liuqi. All rights reserved.
//

import UIKit

class BaseViewModel {
    lazy var anchorGroups: [AnchorGroup] = [AnchorGroup]()
    
    func loadAnchorData(URLString: String, parameters: [String: Any]? = nil, finishCallBack:@escaping ()->()) {
        
        NetworkTools.requestData(type: .get, URLString: URLString, parameter: parameters) { (result) in
            
            guard let resultDict = result as? [String : Any] else {
                return
            }
            
            guard let dataArray = resultDict["data"] as? [[String : Any]] else {
                return
            }
            
            for dict in dataArray {
                self.anchorGroups.append(AnchorGroup(dict: dict));
            }
            
            finishCallBack()
        }
        
    }
}


