//
//  String.swift
//  skillup_test_6
//
//  Created by OkuderaYuki on 2017/05/27.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import Foundation

extension String {
    
    /// 1行毎に分割してArrayにする
    var lines: [String] {
        var lines = [String]()
        self.enumerateLines { (line, _) -> () in
            lines.append(line)
        }
        return lines
    }
    
    /// 文字数を取得する
    var length: Int {
        return self.characters.count
    }
}
