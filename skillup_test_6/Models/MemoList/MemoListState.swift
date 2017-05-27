//
//  MemoListState.swift
//  skillup_test_6
//
//  Created by OkuderaYuki on 2017/05/27.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import Foundation

/// メモ一覧の状態を管理するenum
///
/// - normal: 通常モード
/// - edit: 編集モード
enum MemoListState {
    case normal, edit
    
    /// メモ一覧の状態を変更する
    ///
    /// - Returns: 変更後のMemoListState
    func change() -> MemoListState {
        return self == .normal ? .edit : .normal
    }
}
