//
//  RecommendViewModel.swift
//  DYTV
//
//  Created by liuqi on 16/11/22.
//  Copyright © 2016年 liuqi. All rights reserved.
//

import UIKit

class RecommendViewModel: BaseViewModel {
    lazy var cycleModels: [CycleModel] = [CycleModel]()
    // 热门
    fileprivate lazy var bigDataGroup: AnchorGroup = AnchorGroup()
    // 颜值
    fileprivate lazy var prettyDataGroup: AnchorGroup = AnchorGroup()
}

// MARK: - 发送网络请求
extension RecommendViewModel{
    // 请求数据
    func requestData(finishCallBack: @escaping () -> ()){
        // 1.参数
        let parameters = ["limit" : "4", "offset" : "0", "time" : NSDate.getCurrentTime()]
        
        // 2.创建组
        let dGroup = DispatchGroup()
        
        // 3.请求第一部分推荐数据 热门
        dGroup.enter()
        NetworkTools.requestData(type: .get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameter: parameters) { (result) in
            
            // 1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else {return}
            // 2.根据datah获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return}

            // 3.遍历字典,转成模型对象
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            
            // 离开组
            dGroup.leave()
        }
        
        // 4.请求第二部分数据 颜值
        dGroup.enter()
        NetworkTools.requestData(type: .get, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameter: parameters) { (result) in
            
            // 1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else {return}
            // 2.根据datah获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return}
            
            // 3.遍历字典,转成模型对象
            self.bigDataGroup.tag_name = "颜值"
            self.bigDataGroup.icon_name = "home_header_phone"
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.prettyDataGroup.anchors.append(anchor)
            }
            
            // 离开组
            dGroup.leave()
        }
        
        // 请求2-12部分数据
        dGroup.enter()
        loadAnchorData(isGroupData: true, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) {
            dGroup.leave()
        }
        
        dGroup.notify(queue: DispatchQueue.main) { 
            self.anchorGroups.insert(self.prettyDataGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            
            finishCallBack()
        }
    }
    
    func requestCycleData(finishCallBack: @escaping () -> ()){
        NetworkTools.requestData(type: .get, URLString: "http://www.douyutv.com/api/v1/slide/6", parameter: ["version" : "2.300"]) { (result) in
            
            // 1.获取整体字典数据
            guard let resultDict = result as? [String : NSObject] else { return }
            
            // 2.根据data的key获取数据
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            for dict in dataArray {
                let cycleModel = CycleModel(dict: dict)
                self.cycleModels.append(cycleModel)
            }
            
            finishCallBack()
            
        }
    }
    
    
}


