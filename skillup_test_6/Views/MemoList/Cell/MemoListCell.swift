//
//  MemoListCell.swift
//  skillup_test_6
//
//  Created by OkuderaYuki on 2017/05/27.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import UIKit
import STV_Extensions

final class MemoListCell: UITableViewCell {
    
    @IBOutlet weak var memoTitleLabel: UILabel!
    @IBOutlet weak var memoTextLabel: UILabel!
    @IBOutlet weak var memoDateLabel: UILabel!
    
    var item: MemoListCellItem? {
        didSet {
            setCellData()
        }
    }
    
    private func setCellData() {
        memoTitleLabel.text = item?.title
        memoDateLabel.text = item?.date?.dateStyle()
        // 本文(2行目以降)0文字だった場合空文字をセット
        memoTextLabel.text = item?.text.length == 0 ? "" : item?.text
    }
}
