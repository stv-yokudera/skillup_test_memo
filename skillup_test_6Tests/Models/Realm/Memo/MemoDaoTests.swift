//
//  MemoDaoTests.swift
//  skillup_test_6
//
//  Created by OkuderaYuki on 2017/05/27.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import XCTest
@testable import skillup_test_6

final class MemoDaoTests: XCTestCase {
    
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
    
    func testAdd() {
        
        // MARK: 1.textが0文字の場合
        
        // setUp
        // テスト開始前のRealmのレコード数を確認
        XCTAssertEqual(moc.mocRealm().findAll().count, 0)
        
        let emptyString = ""
        let emptyMemoDto = MemoDto()
        emptyMemoDto.text = emptyString
        
        // exercise
        MemoDao.add(model: emptyMemoDto)
        
        // verify
        // レコード数が増えていないことを確認
        XCTAssertEqual(moc.mocRealm().findAll().count, 0)
        
        // MARK: 2.textが1文字以上の場合
        
        // setUp
        // テスト開始前のRealmのレコード数を確認
        XCTAssertEqual(moc.mocRealm().findAll().count, 0)
        
        let text = MocRealm.dummyTexts[0]
        let memoDto = MemoDto()
        memoDto.text = text
        
        // exercise
        MemoDao.add(model: memoDto)
        
        // verify
        // レコード数が増えていることを確認
        XCTAssertEqual(moc.mocRealm().findAll().count, 1)
        // 登録されているレコードのテキストを確認
        XCTAssertEqual(moc.mocRealm().findFirst(key: 1 as AnyObject)?.text, MocRealm.dummyTexts[0])
    }
    
    func testUpdate() {
        
        // MARK: 1.textが1文字以上の場合
        
        // setUp
        
        let memoDto = MemoDto()
        memoDto.text = MocRealm.dummyTexts[0]
        MemoDao.add(model: memoDto)
        
        // テスト開始前のRealmのレコード数を確認
        XCTAssertEqual(moc.mocRealm().findAll().count, 1)
        // 登録されているレコードのテキストを確認
        XCTAssertEqual(moc.mocRealm().findFirst()?.text, MocRealm.dummyTexts[0])
        
        guard let savedMemoDto = moc.mocRealm().findFirst() else {
            XCTAssertFalse(true, "レコード取得失敗")
            return
        }
        let updateMemoDto = MemoDto()
        updateMemoDto.memoId = savedMemoDto.memoId
        updateMemoDto.text = MocRealm.dummyTexts[1]
        
        // exercise
        
        let updateResult = MemoDao.update(model: updateMemoDto)
        
        // verify
        XCTAssertTrue(updateResult)
        
        // 1件登録されていることを確認
        XCTAssertEqual(moc.mocRealm().findAll().count, 1)
        
        // 登録されているレコードのテキストを確認
        XCTAssertEqual(moc.mocRealm().findFirst()?.text, MocRealm.dummyTexts[1])
        
        // MARK: 2.textが0文字の場合
        
        // setUp
        let updateMemoDto2 = MemoDto()
        updateMemoDto2.memoId = savedMemoDto.memoId
        updateMemoDto2.text = ""
        
        // exercise
        let updateResult2 = MemoDao.update(model: updateMemoDto2)
        
        // verify
        XCTAssertTrue(updateResult2)
        // レコードが削除されていることを確認
        XCTAssertEqual(moc.mocRealm().findAll().count, 0)
        
        // MARK: 3.指定Idのレコードが存在しない場合
        
        // setUp
        let updateMemoDto3 = MemoDto()
        updateMemoDto3.memoId = 999
        updateMemoDto3.text = MocRealm.dummyTexts[2]
        
        // exercise
        let updateResult3 = MemoDao.update(model: updateMemoDto3)
        
        // verify
        XCTAssertFalse(updateResult3)
        // 1件も登録されていないことを確認
        XCTAssertEqual(moc.mocRealm().findAll().count, 0)
    }
    
    func testDelete() {
        
        // MARK: 1.レコードを1件削除するテスト
        
        // setUp
        let memoDto = MemoDto()
        memoDto.text = MocRealm.dummyTexts[0]
        MemoDao.add(model: memoDto)
        
        // テスト開始前のRealmのレコード数を確認
        XCTAssertEqual(moc.mocRealm().findAll().count, 1)
        
        // exercise
        MemoDao.delete(memoID: 1)
        
        // verify
        // レコードが削除されていることを確認
        XCTAssertEqual(moc.mocRealm().findAll().count, 0)
    }
    
    func testDeleteAll() {
        
        // MARK: 1.レコードを全件削除するテスト
        
        // setUp
        let memoDto1 = MemoDto()
        memoDto1.text = MocRealm.dummyTexts[0]
        MemoDao.add(model: memoDto1)
        
        let memoDto2 = MemoDto()
        memoDto2.text = MocRealm.dummyTexts[1]
        MemoDao.add(model: memoDto2)
        
        // テスト開始前のRealmのレコード数を確認
        XCTAssertEqual(moc.mocRealm().findAll().count, 2)
        
        // exercise
        MemoDao.deleteAll()
        
        // verify
        // レコードが削除されていることを確認
        XCTAssertEqual(moc.mocRealm().findAll().count, 0)
    }
    
    func testFindByID() {
        
        // MARK: 1.idを指定して、レコードを取得するテスト
        // setUp
        let memoDto = MemoDto()
        memoDto.text = MocRealm.dummyTexts[0]
        MemoDao.add(model: memoDto)
        
        // exercise
        guard let foundMemoDto = MemoDao.findByID(memoID: 1) else {
            XCTAssertFalse(true, "レコード取得失敗")
            return
        }
        
        // verify
        // 取得したレコードを確認
        XCTAssertEqual(foundMemoDto.text, memoDto.text)
        XCTAssertEqual(foundMemoDto.updateDate, memoDto.updateDate)
    }
    
    func testFindAllSortedDate() {
        
        // MARK: updateDateの降順(新しい順)で、レコードを全件取得するテスト
        
        // setUp
        
        // テスト開始前のRealmのレコード数を確認
        XCTAssertEqual(moc.mocRealm().findAll().count, 0)
        
        let memoDto1 = MemoDto()
        memoDto1.text = MocRealm.dummyTexts[0]
        memoDto1.updateDate = Date(timeIntervalSinceNow: TimeInterval(0))
        MemoDao.add(model: memoDto1)
        
        let memoDto2 = MemoDto()
        memoDto2.text = MocRealm.dummyTexts[1]
        memoDto2.updateDate = Date(timeIntervalSinceNow: TimeInterval(-2*60*60*24))
        MemoDao.add(model: memoDto2)
        
        let memoDto3 = MemoDto()
        memoDto3.text = MocRealm.dummyTexts[2]
        memoDto3.updateDate = Date(timeIntervalSinceNow: TimeInterval(-1*60*60*24))
        MemoDao.add(model: memoDto3)
        
        // exercise
        let results = MemoDao.findAllSortedDate()
        
        // verify
        
        // 全件取得できていることを確認
        XCTAssertEqual(moc.mocRealm().findAll().count, 3)
        XCTAssertEqual(results.count, 3)
        
        // updateDateの降順にソートされていることを確認
        XCTAssertEqual(results[0].text, MocRealm.dummyTexts[0])
        XCTAssertEqual(results[1].text, MocRealm.dummyTexts[2])
        XCTAssertEqual(results[2].text, MocRealm.dummyTexts[1])
    }
    
    func testMemoCount() {
        
        // MARK: レコードの総件数を取得するテスト
        
        // setUp
        
        // テスト開始前のRealmのレコード数を確認
        XCTAssertEqual(moc.mocRealm().findAll().count, 0)
        
        let memoDto1 = MemoDto()
        memoDto1.text = MocRealm.dummyTexts[0]
        memoDto1.updateDate = Date(timeIntervalSinceNow: TimeInterval(0))
        MemoDao.add(model: memoDto1)
        
        let memoDto2 = MemoDto()
        memoDto2.text = MocRealm.dummyTexts[1]
        memoDto2.updateDate = Date(timeIntervalSinceNow: TimeInterval(-2*60*60*24))
        MemoDao.add(model: memoDto2)
        
        let memoDto3 = MemoDto()
        memoDto3.text = MocRealm.dummyTexts[2]
        memoDto3.updateDate = Date(timeIntervalSinceNow: TimeInterval(-1*60*60*24))
        MemoDao.add(model: memoDto3)
        
        let memoDto4 = MemoDto()
        memoDto4.text = MocRealm.dummyTexts[3]
        memoDto4.updateDate = Date(timeIntervalSinceNow: TimeInterval(0))
        MemoDao.add(model: memoDto4)
        
        let memoDto5 = MemoDto()
        memoDto5.text = MocRealm.dummyTexts[4]
        memoDto5.updateDate = Date(timeIntervalSinceNow: TimeInterval(0))
        MemoDao.add(model: memoDto5)
        
        // exercise
        let memoCount = MemoDao.memoCount()
        
        // verify
        // 全件数を確認
        XCTAssertEqual(memoCount, 5)
    }

}
