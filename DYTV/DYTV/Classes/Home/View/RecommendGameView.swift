//
//  RecommendGameView.swift
//  DYTV
//
//  Created by liuqi on 16/11/29.
//  Copyright © 2016年 liuqi. All rights reserved.
//

import UIKit

private let kGameCellID = "kGameCellID"
private let kEdgeInsetMargain: CGFloat = 10

class RecommendGameView: UIView {
    
    var groups: [BaseGameModel]?{
        didSet{
            collectionView.reloadData()
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // 让控件不随父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        
        // 注册cell
        collectionView.register(UINib(nibName: "RecommendGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        // 给collectionView添加内边距
        collectionView.contentInset = UIEdgeInsetsMake(0, kEdgeInsetMargain, 0, kEdgeInsetMargain)
    }
}

// MARK: - 快速创建类的方法
extension RecommendGameView{
    class func recommendGameView() -> RecommendGameView{
        return Bundle.main.loadNibNamed("RecommendGameView", owner: self, options: nil)?.last as! RecommendGameView
    }
}


// MARK: - 数据源方法
extension RecommendGameView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! RecommendGameCell
        
        cell.baseGame = groups![indexPath.item]
        
        return cell
    }
}
