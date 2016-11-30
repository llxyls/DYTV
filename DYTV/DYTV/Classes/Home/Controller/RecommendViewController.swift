//
//  RecommendViewController.swift
//  DYTV
//
//  Created by liuqi on 16/10/11.
//  Copyright © 2016年 liuqi. All rights reserved.
//

import UIKit

private let kCycleViewH = kScreenW * 3 / 8
private let kGameViewH: CGFloat = 90

class RecommendViewController: BaseAnchorViewController {
    // MARK: - 懒加载属性
    fileprivate lazy var recommendVM: RecommendViewModel = RecommendViewModel()
    fileprivate lazy var cycleView: RecommendCycleView = {
        let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height: kCycleViewH)
        return cycleView
    }()
    fileprivate lazy var gameView: RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        
        return gameView
    }()
}

// MARK: - 设置UI界面
extension RecommendViewController{
    
    override func setupUI() {
        super.setupUI()
        
        collectionView.addSubview(cycleView)
        collectionView.addSubview(gameView)
        
        collectionView.contentInset = UIEdgeInsetsMake(kCycleViewH+kGameViewH, 0, 0, 0)
    }
}

// MARK: - 
extension RecommendViewController{
    
    override func loadData() {
        baseVM = recommendVM
        
        // 请求数据
        recommendVM.requestData {
            // 1.展示推荐数据
            self.collectionView.reloadData()
            // 2.将数据传递给GameView
            var groups = self.recommendVM.anchorGroups
            
            // 2.1.移除前两组数据
            groups.removeFirst()
            groups.removeFirst()
            
            // 2.2.添加更多组
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups.append(moreGroup)
            
            self.gameView.groups = groups
            
            // 显示
            self.loadDataFinished()
            
        }
        
        // 请求图片轮播图数据
        recommendVM.requestCycleData {
            self.cycleView.cycleModels = self.recommendVM.cycleModels
        }
        
    }
}

// MARK: -
extension RecommendViewController: UICollectionViewDelegateFlowLayout{
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            let prettyCell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionViewPrettyCell
            
            prettyCell.anchor = recommendVM.anchorGroups[indexPath.section].anchors[indexPath.item]
            
            return prettyCell;
        } else {
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if indexPath.section == 1{
            return CGSize(width: kNormalItemW, height: kPrettyItemH)
        }
        
        return CGSize(width: kNormalItemW, height: kNormalItemH)
    }
}


