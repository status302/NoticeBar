//
//  Bundle+NoticeBar.swift
//  MessageToast
//
//  Created by 程庆春 on 2016/12/10.
//  Copyright © 2016年 qiuncheng.com. All rights reserved.
//

import Foundation

extension Bundle {
    static func currentBundle() -> Bundle {
        let bundle = Bundle(for: NoticeBar.self)
        if let path = bundle.path(forResource: "NoticeBar", ofType: "bundle") {
            return Bundle(path: path)!
        } else {
            return bundle
        }
    }
}
