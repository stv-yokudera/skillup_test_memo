//
//  WriteMemoViewController.swift
//  skillup_test_6
//
//  Created by OkuderaYuki on 2017/05/27.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import UIKit

/// メモ画面
final class WriteMemoViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    /// メモID (編集の場合: メモ一覧画面から受け取る, 新規の場合: nil)
    var memoId: Int?
    
    // MARK : - factory
    
    class func make(havingMemoId: Int?) -> WriteMemoViewController {
        
        if let writeMemoVC = R.storyboard.writeMemoViewController.writeMemoViewController() {
            writeMemoVC.memoId = havingMemoId
            return writeMemoVC
        }
        fatalError("WriteMemoViewController is nil.")
    }
    
    // MARK: - view life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - private method
    
    /// 初期処理
    private func setup() {
        if let memoId = memoId {
            textView.text = MemoDao.findByID(memoID: memoId)?.text
        }
        textView.becomeFirstResponder()
    }
    
    // MARK: - action
    
    @IBAction func didTapDoneButton(_ sender: Any) {
        RegisterMemo.register(memoId: memoId, text: textView.text)
        navigationController?.popViewController(animated: true)
    }
}
