//
//  MocRealm.swift
//  skillup_test_6
//
//  Created by OkuderaYuki on 2017/05/27.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import XCTest
import STV_Extensions
@testable import skillup_test_6

final class MocRealm: XCTestCase {
    
    func mocRealm() -> RealmDaoHelper<MemoDto> {
        return RealmDaoHelper<MemoDto>.init()
    }
    
    // MARK: - テスト用テキスト
    
    static let dummyTexts = ["0", "1", "2", "3", "4"]
}
