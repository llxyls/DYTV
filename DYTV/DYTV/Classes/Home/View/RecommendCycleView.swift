//
//  RecommendCycleView.swift
//  DYTV
//
//  Created by liuqi on 16/11/25.
//  Copyright © 2016年 liuqi. All rights reserved.
//

import UIKit


private let kCycleCellID = "kCycleCellID"

class RecommendCycleView: UIView {
    
    // MARK: - 属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    var cycleTimer: Timer?
    var cycleModels: [CycleModel]?{
        didSet{
            // 1.刷新collectionView
            collectionView.reloadData()
            // 2.设置pageControl的个数
            pageControl.numberOfPages = cycleModels?.count ?? 0
            // 3.默认滚到中间某一位置
            let indexPath = IndexPath(item: (cycleModels?.count ?? 0) * 10, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            // 4.添加定时器
            removeCycleTimer()
            addCyceTimer()
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 设置该空间不随父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing();
        
        // 注册cell
        collectionView.register(UINib(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
    }
}

// MARK: - 快速创建方法
extension RecommendCycleView{
    class func recommendCycleView() -> RecommendCycleView{
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.last as! RecommendCycleView
    }
}

// MARK: - 数据源方法
extension RecommendCycleView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return (cycleModels?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! CollectionCycleCell
        
        cell.cycleModel = cycleModels![indexPath.item % cycleModels!.count]
        
        return cell
    }
}

extension RecommendCycleView: UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 1.获取滚动偏移量
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        // 2.计算pageControl的currentIndex
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % (cycleModels?.count ?? 1)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCyceTimer()
    }
}

// MARK: - 定时器方法
extension RecommendCycleView {
    fileprivate func addCyceTimer() {
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: RunLoopMode.commonModes)
    }
    
    fileprivate func removeCycleTimer() {
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    
    @objc fileprivate func scrollToNext() {
        // 1. 获取滚动偏移量
        let currentOffsetX = collectionView.contentOffset.x
        let offsetX = currentOffsetX + collectionView.bounds.width
        // 2. 滚动到该位置
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}

