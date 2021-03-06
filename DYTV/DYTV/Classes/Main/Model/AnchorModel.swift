//
//  AnchorModel.swift
//  DYTV
//
//  Created by liuqi on 16/10/28.
//  Copyright © 2016年 liuqi. All rights reserved.
//

import UIKit


class AnchorModel: NSObject {
    // MARK: - 属性
    /// 房间ID
    var room_id: Int = 0
    /// 房间图片对应的URLString
    var vertical_src: String = ""
    /// 判断是电脑直播,还是手机直播   0:电脑直播  1:手机直播
    var isVertical: Int = 0
    /// 房间名称
    var room_name: String = ""
    /// 主播名称
    var nickname: String = ""
    /// 观看人数
    var online: Int = 0
    /// 所在城市
    var anchor_city: String = ""
    
    init(dict: [String: Any]) {
        super.init()
    
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}
