//
//  CollectionViewBaseCell.swift
//  DYTV
//
//  Created by liuqi on 16/10/13.
//  Copyright © 2016年 liuqi. All rights reserved.
//

import UIKit
import Kingfisher


class CollectionViewBaseCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var nickNameLabel: UILabel!
    
    var anchor: AnchorModel? {
        didSet{
            guard  let anchor = anchor else {return}
            var onlineStr: String = ""
            if anchor.online >= 10000 {
                onlineStr = "\(anchor.online/10000)万在线"
            } else {
                onlineStr = "\(anchor.online)在线"
            }
            
            // 在线人数
            onlineBtn.setTitle(onlineStr, for: .normal)
            // 昵称的显示
            nickNameLabel.text = anchor.nickname
            // 图片
            guard  let iconURL = URL(string: anchor.vertical_src) else {return}
            iconImageView.kf.setImage(with: iconURL)
        }
    }
}
