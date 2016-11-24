//
//  BaseViewController.swift
//  DYTV
//
//  Created by liuqi on 16/11/24.
//  Copyright © 2016年 liuqi. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var contentView : UIView?
    
    fileprivate lazy var animImageView : UIImageView = { [unowned self] in
        let imageView = UIImageView(image: UIImage(named: "img_loading_1"))
        imageView.center = self.view.center
        imageView.animationImages = [UIImage(named: "img_loading_1")!, UIImage(named: "img_loading_2")!]
        imageView.animationDuration = 1.5
        imageView.animationRepeatCount = LONG_MAX
        imageView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        contentView?.isHidden = true
        // 动画
        view.addSubview(animImageView)
        animImageView.startAnimating()
        
        view.backgroundColor = UIColor(r: 250, g: 250, b: 250)
    }
    
    func loadDataFinished(){
        animImageView.stopAnimating()
        animImageView.isHidden = true
        contentView?.isHidden = false;
    }

}
