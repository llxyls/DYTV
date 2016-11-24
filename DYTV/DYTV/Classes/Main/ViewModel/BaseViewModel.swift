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
    
    func loadAnchorData(isGroupData: Bool, URLString: String, parameters: [String: Any]? = nil, finishCallBack:@escaping ()->()) {
        
        NetworkTools.requestData(type: .get, URLString: URLString, parameter: parameters) { (result) in
            
            // 数据初步处理
            guard let resultDict = result as? [String : Any] else {
                return
            }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else {
                return
            }
            
            if isGroupData { // 分组  推荐娱乐界面
                for dict in dataArray {
                    self.anchorGroups.append(AnchorGroup(dict: dict));
                }
            } else { // 不分组 趣玩界面
                let group = AnchorGroup()
                for dict in dataArray {
                    group.anchors.append(AnchorModel(dict: dict))
                }
                self.anchorGroups.append(group)
            }
            
            finishCallBack()
        }
        
    }
}


