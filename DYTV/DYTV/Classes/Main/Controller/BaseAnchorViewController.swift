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

private let kNormalItemW = (kScreenW - 3 * kItemMargin) / 2
private let kNormalItemH = kNormalItemW * 3 / 4

private let kNormalCellID = "kNormalCellID"
private let kPrettyCellID = "kPrettyCellID"

class BaseAnchorViewController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    
    private lazy var collectionView: UICollectionView = {[unowned self] in
        // 创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        // 创建collectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        loadData()
    }
    
    override func setupUI(){
        contentView = collectionView
        view.addSubview(collectionView)
        // 调用父类的方法
        super.setupUI()
    }
    
    func loadData(){
        
    }
    
    // MARK:==UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int{
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = UICollectionViewCell()
        
        return cell
    }
}
