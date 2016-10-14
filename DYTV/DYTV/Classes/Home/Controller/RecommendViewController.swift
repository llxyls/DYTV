//
//  RecommendViewController.swift
//  DYTV
//
//  Created by liuqi on 16/10/11.
//  Copyright © 2016年 liuqi. All rights reserved.
//

import UIKit

class RecommendViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       NetworkTools.requestData(type: .get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameter: ["time" : NSDate.getCurrentTime()]) { (result) in
        print(result)
        
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
