//
//  MemoListToolbarTests.swift
//  skillup_test_6
//
//  Created by OkuderaYuki on 2017/05/27.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import XCTest
@testable import skillup_test_6

final class MemoListToolbarTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testRightToolbarButtonTitle() {
        
        // MARK: 1.メモ1件以上の場合 (100件)
        
        // setUp
        let memoCount = 100
        // exercise
        let title = MemoListToolbar.rightToolbarButtonTitle(count: memoCount)
        // verify
        XCTAssertEqual(title, "100件のメモ")
        
        // MARK: 2.メモ0件の場合
        
        // setUp
        let memoCountZero = 0
        // exercise
        let countZeroTitle = MemoListToolbar.rightToolbarButtonTitle(count: memoCountZero)
        // verify
        XCTAssertEqual(countZeroTitle, "メモなし")
    }
    
    func testLeftToolbarButtonTitle() {
        
        // MARK: 1.通常モードの場合
        
        // setUp
        let stateNormal: MemoListState = .normal
        // exercise
        let stateNormalTitle = MemoListToolbar.leftToolbarButtonTitle(state: stateNormal)
        // verify
        XCTAssertEqual(stateNormalTitle, "メモ追加")
        
        // MARK: 2.編集モードの場合
        
        // setUp
        let stateEdit: MemoListState = .edit
        // exercise
        let stateEditTitle = MemoListToolbar.leftToolbarButtonTitle(state: stateEdit)
        // verify
        XCTAssertEqual(stateEditTitle, "すべて削除")
    }
}
