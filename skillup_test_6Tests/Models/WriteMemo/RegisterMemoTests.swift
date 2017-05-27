//
//  RegisterMemoTests.swift
//  skillup_test_6
//
//  Created by OkuderaYuki on 2017/05/27.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import XCTest
@testable import skillup_test_6

final class RegisterMemoTests: XCTestCase {
    
    var moc = MocRealm()
    
    override func setUp() {
        super.setUp()
        moc = MocRealm()
        moc.mocRealm().deleteAll()
    }
    
    override func tearDown() {
        moc.mocRealm().deleteAll()
        super.tearDown()
    }
    
    func testRegister() {
        
        // MARK: 1.memoIdがnilの場合のテスト (新規メモを追加)
        
        // setUp
        // テスト開始前のRealmのレコード数を確認
        XCTAssertEqual(moc.mocRealm().findAll().count, 0)
        
        // exercise
        RegisterMemo.register(memoId: nil, text: MocRealm.dummyTexts[0])
        
        // verify
        // 1件登録されていることを確認
        XCTAssertEqual(moc.mocRealm().findAll().count, 1)
        
        // 登録されているレコードのテキストを確認
        XCTAssertEqual(moc.mocRealm().findFirst()?.text, MocRealm.dummyTexts[0])
        
        // MARK: 2.memoIdがnilでない場合のテスト (既存メモ更新)
        
        // setUp
        guard let savedMemoDto = moc.mocRealm().findFirst() else {
            XCTAssertFalse(true, "レコード取得失敗")
            return
        }
        let savedMemoId = savedMemoDto.memoId
        
        // exercise
        RegisterMemo.register(memoId: savedMemoId, text: MocRealm.dummyTexts[1])
        
        // verify
        // 1件登録されていることを確認
        XCTAssertEqual(moc.mocRealm().findAll().count, 1)
        
        // 登録されているレコードのテキストを確認
        XCTAssertEqual(moc.mocRealm().findFirst(key: savedMemoId as AnyObject)?.text, MocRealm.dummyTexts[1])

    }
}
