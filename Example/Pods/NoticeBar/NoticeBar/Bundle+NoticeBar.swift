//
//  Created by Qiun Cheng on 2016/12/10.
//  Copyright © 2016年 http://qiuncheng.com. All rights reserved.
//
//  MIT License
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//

import Foundation

extension Bundle {
    /// Create a new Bundle instance for 'Image.xcassets'.
    ///
    /// - Returns: a new bundle which contains 'Image.xcassets'.
    static func currentBundle() -> Bundle {
        let bundle = Bundle(for: NoticeBar.self)
        if let path = bundle.path(forResource: "NoticeBar", ofType: "bundle") {
            return Bundle(path: path)!
        } else {
            return bundle
        }
    }
}
