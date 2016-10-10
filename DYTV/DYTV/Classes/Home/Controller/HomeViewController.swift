//
//  HomeViewController.swift
//  DYTV
//
//  Created by liuqi on 16/10/9.
//  Copyright © 2016年 liuqi. All rights reserved.
//

import UIKit

private let titleViewH : CGFloat = 40

class HomeViewController: UIViewController {

    
    private lazy var pageTitleView: PageTitleView = {
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: titleViewH)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        
        let pageTitleView = PageTitleView(frame: titleFrame, titles: titles)
        return pageTitleView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false
        
        view.addSubview(pageTitleView)
    }

}
