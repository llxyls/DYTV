//
//  CollectionHeaderView.swift
//  DYTV
//
//  Created by liuqi on 16/11/28.
//  Copyright © 2016年 liuqi. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var moreBtn: UIButton!
    
    var group: AnchorGroup?{
        didSet{
            titleLabel.text = group?.tag_name
            iconImageView.image = UIImage(named: group?.icon_name ?? "home_header_normal")
        }
    }
}

extension CollectionHeaderView{
    func collectionHeaderView() -> CollectionHeaderView {
        return Bundle.main.loadNibNamed("CollectionHeaderView", owner: self, options: nil)?.last as! CollectionHeaderView
    }
}
