//
//  PageContentView.swift
//  DYTV
//
//  Created by liuqi on 16/10/10.
//  Copyright © 2016年 liuqi. All rights reserved.
//

import UIKit


protocol PageContentViewDelegate: class {
    func pageContentView(_ contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int)
}

private let ContentCellID = "ContentCellID"

class PageContentView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    weak var delegate: PageContentViewDelegate?
    fileprivate var startOffsetX: CGFloat = 0
    fileprivate var isForbidScrollDelegate: Bool = false
    fileprivate var childVcs: [UIViewController] = [UIViewController]()
    fileprivate weak var parentViewController: UIViewController?
    fileprivate lazy var collectionView: UICollectionView = {[weak self] in
        // 创建FlowLayoutLayout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        // 创建collectionView
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.scrollsToTop = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: ContentCellID)
        
        return collectionView
    }()
    
    init(frame: CGRect, childVcs: [UIViewController], parentViewController: UIViewController?) {
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        super.init(frame: frame)
        
        // 设置UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupUI() {
        for childVc in childVcs{
            parentViewController?.addChildViewController(childVc)
        }
        
        addSubview(collectionView)
        collectionView.frame = bounds
    }
    
    // MARK:==对外暴露的方法
    func setCurrentIndex(_ currentIndex: Int){
        // 不需要代理方法改变offset
        isForbidScrollDelegate = true
        
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
    
    // MARK:==UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        
        for view in cell.contentView.subviews{
            view.removeFromSuperview()
        }
        
        let childVc = childVcs[indexPath.row]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
    
    // MARK:==UICollectionViewDelegate
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isForbidScrollDelegate = false
        
        // 记录初始位置
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 不是拖拽就返回
        if isForbidScrollDelegate {return}
        
        // 定义获取需要的数据
        var progress: CGFloat = 0
        var sourceIndex: Int = 0
        var targetIndex: Int = 0
        
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.frame.width
        // 判断左划还是右划
        if currentOffsetX > startOffsetX { // 左划
            // 计算progress
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            // 计算sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewW)
            // 计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            
            // 如果完全划过去
            if (currentOffsetX - startOffsetX) == scrollViewW{
                progress = 1
                targetIndex = sourceIndex;
            }
 
        } else { // 右划
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            
            targetIndex = Int(currentOffsetX / scrollViewW)
            
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
        }
        
        delegate?.pageContentView(self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
    
}


