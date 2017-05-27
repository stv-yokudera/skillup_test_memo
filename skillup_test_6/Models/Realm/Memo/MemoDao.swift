//
//  MemoDao.swift
//  skillup_test_6
//
//  Created by OkuderaYuki on 2017/05/27.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import Foundation
import RealmSwift

final class MemoDao {
    
    static let daoHelper = RealmDaoHelper<MemoDto>()
    
    /// レコードを追加する (textが空の場合は、追加しない)
    static func add(model: MemoDto) {
        
        // 空文字判定
        if model.text.length == 0 {
            // 追加しない
            return
        }
        
        let newObject = MemoDto()
        
        if let newId = MemoDao.daoHelper.newId() {
            newObject.memoId = newId
        }
        newObject.text = model.text
        newObject.updateDate = model.updateDate
        
        MemoDao.daoHelper.add(d: newObject)
    }
    
    /// レコードを更新する (textが空の場合は、削除する)
    static func update(model: MemoDto) -> Bool {
        
        guard let object = daoHelper.findFirst(key: model.memoId as AnyObject) else {
            return false
        }
        
        // 空文字判定
        if model.text.length == 0 {
            // 削除する
            daoHelper.delete(d: object)
            return true
        }
        
        // update
        do {
            daoHelper.realm.beginWrite()
            object.text = model.text
            object.updateDate = model.updateDate
            try daoHelper.realm.commitWrite()
            return true
        } catch let error {
            Logger.error(message: error.localizedDescription)
            daoHelper.realm.cancelWrite()
            return false
        }
    }
    
    /// memoIDを指定して、レコードを削除する
    static func delete(memoID: Int) {
        
        guard let object = daoHelper.findFirst(key: memoID as AnyObject) else {
            return
        }
        daoHelper.delete(d: object)
    }
    
    /// レコードを全件削除する
    static func deleteAll() {
        daoHelper.deleteAll()
    }
    
    /// memoIDを指定して、レコードを取得する
    static func findByID(memoID: Int) -> MemoDto? {
        guard let object = daoHelper.findFirst(key: memoID as AnyObject) else {
            return nil
        }
        return object
    }
    
    /// updateDateの降順(新しい順)で、全件取得する
    static func findAllSortedDate() -> [MemoDto] {
        let objects =  MemoDao.daoHelper.findAll().sorted(byKeyPath: "updateDate", ascending: false)
        return objects.map { MemoDto(value: $0) }
    }
    
    /// レコードの総件数を取得する
    static func memoCount() -> Int {
        return MemoDao.daoHelper.findAll().count
    }
    
}
