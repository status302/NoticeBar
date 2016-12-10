//
//  ViewController.swift
//  Example
//
//  Created by 程庆春 on 2016/12/10.
//  Copyright © 2016年 qiuncheng.com. All rights reserved.
//

import UIKit
import NoticeBar

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func showNoticeBar(_ sender: Any) {

        let noticeBar = NoticeBar(title: "haha", defaultType: .error)
        noticeBar.show(duration: 1.8, completed: {
            (finished: Bool) in
        })
    }


}

