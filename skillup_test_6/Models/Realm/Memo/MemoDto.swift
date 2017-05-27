//
//  MemoDto.swift
//  skillup_test_6
//
//  Created by OkuderaYuki on 2017/05/27.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import Foundation
import RealmSwift

/// Realm Memoテーブルモデルクラス
final class MemoDto: Object {
    
    dynamic var memoId = 0
    dynamic var text = ""
    dynamic var updateDate = Date()
    
    override static func primaryKey() -> String? {
        return "memoId"
    }
}
