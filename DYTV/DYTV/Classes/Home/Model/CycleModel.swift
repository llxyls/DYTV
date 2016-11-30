//
//  CycleModel.swift
//  DYTV
//
//  Created by liuqi on 16/11/25.
//  Copyright © 2016年 liuqi. All rights reserved.
//

import UIKit


class CycleModel: NSObject {
    
    // 标题
    var title: String = ""
    // 展示图片的地址
    var pic_url: String = ""
    // 房间号
    var room: [String : NSObject]? {
        didSet{
            guard let room = room else {return}
            anchor = AnchorModel(dict: room)
        }
    }
    // 主播信息对应的模型对象
    var anchor: AnchorModel?
    
    init(dict: [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}
