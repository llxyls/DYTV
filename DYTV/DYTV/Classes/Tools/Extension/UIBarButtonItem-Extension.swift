//
//  UIBarButtonItem-Extension.swift
//  DYTV
//
//  Created by liuqi on 16/10/10.
//  Copyright © 2016年 liuqi. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    convenience init(imageName: String, highImage: String = "", size: CGSize = CGSize()) {
        
        let btn = UIButton()
        // 设置图片
        btn.setImage(UIImage(named: imageName), for: .normal)
        if highImage != "" {
            btn.setImage(UIImage(named: highImage), for: .highlighted)
        }
        // 设置frame
        if size == CGSize() {
            btn.sizeToFit()
        }else{
            btn.frame = CGRect(origin: CGPoint(), size: size)
        }
        
        self.init(customView: btn)
    }
}
