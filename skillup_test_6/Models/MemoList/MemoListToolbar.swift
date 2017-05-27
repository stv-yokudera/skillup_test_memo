//
//  MemoListToolbar.swift
//  skillup_test_6
//
//  Created by OkuderaYuki on 2017/05/27.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import UIKit

final class MemoListToolbar: NSObject {
    
    static func rightToolbarButtonTitle(count: Int) -> String {
        return count == 0 ? R.string.localizable.noMemos() : R.string.localizable.memosCount(count)
    }
    
    static func leftToolbarButtonTitle(state: MemoListState) -> String {
        
        switch state {
        case .normal:
            return R.string.localizable.addMemo()
        case .edit:
            return R.string.localizable.deleteAll()
        }
    }
}
