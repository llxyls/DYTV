//
//  BaseAnchorViewController.swift
//  DYTV
//
//  Created by liuqi on 16/10/13.
//  Copyright © 2016年 liuqi. All rights reserved.
//

import UIKit

private let kItemMargin: CGFloat = 10
private let kHeaderViewH : CGFloat = 50

let kNormalItemW = (kScreenW - 3 * kItemMargin) / 2
let kNormalItemH = kNormalItemW * 3 / 4
private let kNormalCellID = "kNormalCellID"
let kPrettyCellID = "kPrettyCellID"
let kPrettyItemH = kNormalItemW * 4 / 3
private let kHeaderViewID = "kHeaderViewID"

class BaseAnchorViewController: BaseViewController {

    var baseVM: BaseViewModel!
    lazy var collectionView: UICollectionView = {[unowned self] in
        // 创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        // 创建collectionView
        let collectionView: UICollectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        
        // 注册cell
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "CollectionViewPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        loadData()
    }
}

extension BaseAnchorViewController{
    override func setupUI(){
        contentView = collectionView
        view.addSubview(collectionView)
        // 调用父类的方法
        super.setupUI()
    }
}

extension BaseAnchorViewController{
    func loadData(){
        
    }
}

extension BaseAnchorViewController: UICollectionViewDataSource{
    // MARK:==UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int{
        return baseVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return baseVM.anchorGroups[section].anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionViewNormalCell
        
        cell.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView{
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        headerView.group = self.baseVM.anchorGroups[indexPath.section]
        return headerView
    }
}

// MARK:- 遵守UICollectionView的代理协议
extension BaseAnchorViewController : UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        // 1.取出对应的主播信息
//        let anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
//        
//        // 2.判断是秀场房间&普通房间
//        anchor.isVertical == 0 ? pushNormalRoomVc() : presentShowRoomVc()
//    }
//    
//    private func presentShowRoomVc() {
//        // 1.创建ShowRoomVc
//        let showRoomVc = RoomShowViewController()
//        
//        // 2.以Modal方式弹出
//        present(showRoomVc, animated: true, completion: nil)
//    }
//    
//    private func pushNormalRoomVc() {
//        // 1.创建NormalRoomVc
//        let normalRoomVc = RoomNormalViewController()
//        
//        // 2.以Push方式弹出
//        navigationController?.pushViewController(normalRoomVc, animated: true)
//    }
}

