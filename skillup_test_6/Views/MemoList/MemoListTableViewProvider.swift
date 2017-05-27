//
//  MemoListTableViewProvider.swift
//  skillup_test_6
//
//  Created by OkuderaYuki on 2017/05/27.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import UIKit

/// メモ一覧画面のTableViewのDataSourceクラス
final class MemoListTableViewProvider: NSObject {
    
    var cellItems: [MemoListCellItem] = []
    
    var removeCompletion: (() -> Void)?
    
    func getMemoId(indexPath: IndexPath) -> Int {
        return cellItems[indexPath.row].id
    }
    
    /// メモリストセルを生成
    ///
    /// - Parameter memoDtos: Memoモデルオブジェクトの配列
    func cellItems(from memoDtos: [MemoDto]) {
        
        var newCellItems: [MemoListCellItem] = []
        var cellItem = MemoListCellItem()
        
        for memoDto in memoDtos {
            cellItem.id = memoDto.memoId
            cellItem.date = memoDto.updateDate
            // memoDto.textの1行目
            cellItem.title = memoDto.text.lines[0]
            // memoDto.textの1行目以外
            cellItem.text = memoDto.text.lines.dropFirst().joined(separator: "\n")
            
            newCellItems.append(cellItem)
        }
        self.cellItems = newCellItems
    }
}

// MARK: - UITableViewDataSource
extension MemoListTableViewProvider: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.memoListCell.identifier,
                                                 for: indexPath) as! MemoListCell
        cell.item = cellItems[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        // 削除対象のCellの情報をDBから削除
        let removeMemoId = getMemoId(indexPath: indexPath)
        MemoDao.delete(memoID: removeMemoId)
        
        // DBから全件分情報を取得して、cellItemsを更新
        self.cellItems(from: MemoDao.findAllSortedDate())
        
        tableView.deleteRows(at: [IndexPath(row: indexPath.row, section: 0)],
                             with: .fade)
        
        if let removeCompletion = self.removeCompletion {
            removeCompletion()
        }
    }
}
