//
//  UITextView.swift
//  skillup_test_6
//
//  Created by OkuderaYuki on 2017/05/27.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import UIKit

extension UITextView {
    /// UITextViewのタップイベント
    /// keyboardが表示されている場合: keyboardを閉じる
    /// keyboardが表示されていない場合: keyboardを表示する
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        _ = self.isFirstResponder ? self.resignFirstResponder() : self.becomeFirstResponder()
    }
}
