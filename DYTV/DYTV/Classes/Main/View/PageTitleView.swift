//
//  PageTitleView.swift
//  DYTV
//
//  Created by liuqi on 16/10/9.
//  Copyright © 2016年 liuqi. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate:class {
    func pageTitleView(titleView: PageTitleView, selectIndex: Int)
}

private let kScrollLineH: CGFloat = 2
private let kNormalColor: (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectColor: (CGFloat, CGFloat, CGFloat) = (225, 128, 0)

class PageTitleView: UIView {
    
    // MARK:-属性
    private var currentIndex: Int = 0
    private var titles: [String] = []
    weak var delegate: PageTitleViewDelegate?
    // MARK:-懒加载属性
    private lazy var titleLabels: [UILabel] = [UILabel]()
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        return scrollView
    }()
    private lazy var scrollLine: UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:==设置UI界面
    private func setupUI(){
        // 添加scrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        // 设置titleView
        setupTitleLabels()
        // 设置scrollLine
        setupBottomLineAndScrollLine()
    }
    /// 设置标题
    private func setupTitleLabels(){
        let labelW: CGFloat = frame.width / CGFloat(titles.count)
        let labelH: CGFloat = frame.height - kScrollLineH
        let labelY: CGFloat = 0
        
        for (index, title) in titles.enumerated(){
            // 初始化
            let label = UILabel()
            // 设置label的属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.textAlignment = .center
            // 设置label的frame
            let labelX: CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            // 添加到父控件,数组中
            scrollView .addSubview(label)
            titleLabels.append(label)
            // 添加手势
            label.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tap)
        }
    }
    
    // 标题点击
    @objc private func titleLabelClick(tapGes: UITapGestureRecognizer){
        // 是否手势触发
        guard let currentLabel = tapGes.view as? UILabel else {
            return
        }
        // 是否当前Label
        if currentLabel.tag == currentIndex {
            return
        }
        // 之前的label
        let oldLabel = titleLabels[currentIndex]
        // 改变状态
        currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        // 设置新的currentIndex
        currentIndex = currentLabel.tag
        // 改变滚动条位置
        let scrollLineX = CGFloat(currentIndex) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        // 通知代理
        delegate?.pageTitleView(titleView: self, selectIndex: currentIndex)
    }
    /// 设置底部滚动线和阴影
    private func setupBottomLineAndScrollLine(){
        // 阴影
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH: CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        // 滚动线
        guard let firstLabel = titleLabels.first else {return}
        firstLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
    }
    
    // MARK:==对外暴露的方法
    func setTitleWithProgress(progress: CGFloat, sourceIndex: Int, targetIndex: Int){
        
        
        
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        
        
        // 处理滑块逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        // 颜色渐变
        let colorDelta = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.1, kSelectColor.2 - kNormalColor.2)
        
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)
        
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        
        if sourceIndex == targetIndex {
            targetLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        }
        
        currentIndex = targetIndex
    }
}

















