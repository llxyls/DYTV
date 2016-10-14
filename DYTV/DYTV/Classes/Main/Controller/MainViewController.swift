//
//  MainViewController.swift
//  DYTV
//
//  Created by liuqi on 16/10/8.
//  Copyright © 2016年 liuqi. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildVc("Home", title: "首页", imageName: "btn_home_normal", selImageName: "btn_home_selected")
        addChildVc("Follow", title: "关注", imageName: "btn_live_normal", selImageName: "btn_live_selected")
        addChildVc("Live", title: "直播", imageName: "btn_column_normal", selImageName: "btn_column_selected")
        addChildVc("Profile", title: "我", imageName: "btn_user_normal", selImageName: "btn_user_selected")
    }
    
    func addChildVc(_ storyboardName: String, title: String, imageName: String, selImageName: String) {
        let childVc = UIStoryboard(name: storyboardName, bundle: nil).instantiateInitialViewController()!
        
        childVc.tabBarItem.title = title
        childVc.tabBarItem.image = UIImage(named: imageName)
        childVc.tabBarItem.selectedImage = UIImage(named: selImageName)
        
        addChildViewController(childVc)
    }
}
