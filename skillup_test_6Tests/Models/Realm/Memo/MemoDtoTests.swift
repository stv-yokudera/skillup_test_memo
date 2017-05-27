//
//  MemoDtoTests.swift
//  skillup_test_6
//
//  Created by OkuderaYuki on 2017/05/27.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import XCTest
@testable import skillup_test_6

final class MemoDtoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testMemoDto() {
        
        // MARK: 1.MemoDtoに値をセットするテスト
        
        // setUp
        let memoId = 1
        let text = "タイトル\nテキストテキスト"
        let date = Date()
        
        // exercise
        let memoDto = MemoDto()
        memoDto.memoId = memoId
        memoDto.text = text
        memoDto.updateDate = date
        
        // verify
        XCTAssertEqual(memoDto.memoId, 1)
        XCTAssertEqual(memoDto.text, "タイトル\nテキストテキスト")
        XCTAssertEqual(memoDto.updateDate, date)
    }
    
    func testPrimaryKey() {
        
        // MARK: 1.PrimaryKeyを設定するテスト
        
        // exercise
        let primaryKey = MemoDto.primaryKey()
        
        // verify
        XCTAssertNotNil(primaryKey)
        XCTAssertEqual(primaryKey, "memoId")
    }
}
