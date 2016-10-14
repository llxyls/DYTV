//
//  NSDate-Extension.swift
//  DYTV
//
//  Created by liuqi on 16/10/14.
//  Copyright © 2016年 liuqi. All rights reserved.
//

import Foundation

extension NSDate{
    static func getCurrentTime() -> String{
        let nowDate = NSDate()
        
        let interval = Int(nowDate.timeIntervalSince1970)
        
        return "\(interval)"
    }
}
