//
//  BaseGameModel.swift
//  DYTV
//
//  Created by liuqi on 16/10/28.
//  Copyright © 2016年 liuqi. All rights reserved.
//

import UIKit


class BaseGameModel: NSObject {
    // MARK: - 属性
    var tag_name: String = ""
    var icon_url: String = ""
    
    override init() {
    }
    
    // MARK: - 自定义构造函数
    init(dict: [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
