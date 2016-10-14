//
//  HomeViewController.swift
//  DYTV
//
//  Created by liuqi on 16/10/9.
//  Copyright © 2016年 liuqi. All rights reserved.
//

import UIKit

private let titleViewH : CGFloat = 40

class HomeViewController: UIViewController, PageTitleViewDelegate, PageContentViewDelegate {

    
    fileprivate lazy var pageTitleView: PageTitleView = {[weak self] in
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: titleViewH)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
        }()
    
    fileprivate lazy var pageContentView: PageContentView = {[weak self] in
        let contentH = kScreenH - kNavigationBarH - kStatusBarH - kTabBarH - titleViewH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + titleViewH, width: kScreenW, height: contentH)
        
        var childVcs = [UIViewController]()
        for _ in 0...3 {
            let childVc = UIViewController()
            childVc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
            childVcs.append(childVc)
        }
        
        let pageContentView: PageContentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        
        pageContentView.delegate = self
        
        return pageContentView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 不需要调整UIScrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        // 设置navigationBar
        setupNavigationBar()
        // 添加pageTitleView
        view.addSubview(pageTitleView)
        // 添加contentView
        view.addSubview(pageContentView)
    }
    
    // navigationBar
    func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImage: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImage: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImage: "Image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
    }
    
    // MARK:- 代理方法
    /// PageTitleViewDelegate
    func pageTitleView(_ titleView: PageTitleView, selectIndex: Int){
        pageContentView.setCurrentIndex(selectIndex)
    }
    /// PageContentViewDelegate
    func pageContentView(_ contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int){
        pageTitleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

