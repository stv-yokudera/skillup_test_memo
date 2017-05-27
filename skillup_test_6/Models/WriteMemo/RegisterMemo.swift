//
//  RegisterMemo.swift
//  skillup_test_6
//
//  Created by OkuderaYuki on 2017/05/27.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import Foundation

final class RegisterMemo: NSObject {
    
    
    /// メモ登録処理
    ///
    /// - Parameters:
    ///   - memoId: 新規メモ登録: nil, 既存メモ更新: 登録済みのmemoId
    ///   - text: テキスト
    static func register(memoId: Int?, text: String) {
        
        let memoDto = MemoDto()
        memoDto.text = text
        
        if let memoId = memoId {
            memoDto.memoId = memoId
            _ = MemoDao.update(model: memoDto)
            return
        }
        MemoDao.add(model: memoDto)
    }
}
