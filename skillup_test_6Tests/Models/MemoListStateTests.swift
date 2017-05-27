//
//  MemoListStateTests.swift
//  skillup_test_6
//
//  Created by OkuderaYuki on 2017/05/27.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import XCTest
@testable import skillup_test_6

final class MemoListStateTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testChange() {
        
        // MARK: 1.通常モードから編集モードに変更する場合
        
        // setUp
        var state1: MemoListState = .normal
        // exercise
        state1 = state1.change()
        // verify
        XCTAssertEqual(state1, .edit)
        
        // MARK: 2.編集モードから通常モードに変更する場合
        
        // setUp
        var state2: MemoListState = .edit
        // exercise
        state2 = state2.change()
        // verify
        XCTAssertEqual(state2, .normal)
    }
}
