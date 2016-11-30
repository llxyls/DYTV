//
//  RecommendGameCell.swift
//  DYTV
//
//  Created by liuqi on 16/11/29.
//  Copyright © 2016年 liuqi. All rights reserved.
//

import UIKit

class RecommendGameCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    
    var baseGame: BaseGameModel?{
        didSet{
            titleLabel.text = baseGame?.tag_name
            if let iconURL = URL(string: baseGame?.icon_url ?? ""){
                iconImageView.kf.setImage(with: iconURL)
            }else{
                iconImageView.image = UIImage(named: "home_more_btn");
            }
        }
    }

}
