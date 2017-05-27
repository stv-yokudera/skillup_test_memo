//
//  MemoListCellItemTests.swift
//  skillup_test_6
//
//  Created by OkuderaYuki on 2017/05/27.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import XCTest
@testable import skillup_test_6

final class MemoListCellItemTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testMemoListCellItem() {
        
        // MARK: 1.MemoListCellItemに値をセットするテスト
        
        // setUp
        let memoId = 1
        let title = "タイトル"
        let date = Date()
        let text = "1/3行。\n2/3行。\n3/3行"
        
        // exercise
        var memoListCellItem = MemoListCellItem()
        memoListCellItem.id = memoId
        memoListCellItem.title = title
        memoListCellItem.date = date
        memoListCellItem.text = text
        
        // verify
        XCTAssertEqual(memoListCellItem.id, 1)
        XCTAssertEqual(memoListCellItem.title, "タイトル")
        XCTAssertEqual(memoListCellItem.date, date)
        XCTAssertEqual(memoListCellItem.text, "1/3行。\n2/3行。\n3/3行")
    }
}
