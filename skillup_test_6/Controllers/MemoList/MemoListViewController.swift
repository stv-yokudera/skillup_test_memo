//
//  MemoListViewController.swift
//  skillup_test_6
//
//  Created by OkuderaYuki on 2017/05/27.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import UIKit

/// メモ一覧画面
final class MemoListViewController: UIViewController {
    
    @IBOutlet weak var rightToolbarButton: UIBarButtonItem!
    @IBOutlet weak var leftToolbarButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!

    private var memoListState = MemoListState.normal
    
    let tableViewProvider = MemoListTableViewProvider()
    
    // MARK: - view life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadToolbar()
        reloadTableView()
    }
    
    // MARK: - UIViewController
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        memoListState = memoListState.change()
        reloadToolbar()
        tableView.isEditing = !tableView.isEditing
    }
    
    // MARK: - action
    
    @IBAction func didTapLeftToolbarButton(_ sender: Any) {
        switch memoListState {
        case .normal:
            let writeMemoVC = WriteMemoViewController.make(havingMemoId: nil)
            navigationController?.pushViewController(writeMemoVC, animated: true)
        case .edit:
            showActionSheet()
        }
    }
    
    // MARK: - private methods
    
    /// 初期処理
    private func setup() {
        navigationItem.title = NSLocalizedString("memo", comment: "メモ")
        navigationItem.rightBarButtonItem = editButtonItem
        setupTableView()
    }
    
    /// tableviewの初期処理
    private func setupTableView() {
        // tableView cell削除後の処理をremoveCompletionに実装
        tableViewProvider.removeCompletion = { [weak self] _ in
            guard let `self` = self else { return }
            self.reloadToolbar()
        }
        registerNib()
        tableView.dataSource = tableViewProvider
        tableView.delegate = self
    }
    
    /// custom cellをTableViewに登録する
    private func registerNib() {
        // MemoListCell
        tableView.register(R.nib.memoListCell(),
                           forCellReuseIdentifier: R.reuseIdentifier.memoListCell.identifier)
    }
    
    /// toolbarの更新処理
    private func reloadToolbar() {
        let memoCount = MemoDao.memoCount()
        rightToolbarButton.title = MemoListToolbar.rightToolbarButtonTitle(count: memoCount)
        leftToolbarButton.title = MemoListToolbar.leftToolbarButtonTitle(state: memoListState)
    }
    /// tableViewの更新処理
    private func reloadTableView() {
        // DBから全件分情報を取得して、cellItemsを生成
        tableViewProvider.cellItems(from: MemoDao.findAllSortedDate())
        tableView.reloadData()
    }
    
    private func showActionSheet() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: R.string.localizable.deleteAll(), style: .destructive) { [weak self] (action) in
            
            guard let `self` = self else { return }
            MemoDao.deleteAll()
            self.reloadTableView()
            self.reloadToolbar()
        }
        let cancelAction = UIAlertAction(title: R.string.localizable.cancel(), style: .cancel, handler: nil)
        
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDelegate
extension MemoListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMemoId = tableViewProvider.getMemoId(indexPath: indexPath)
        let writeMemoVC = WriteMemoViewController.make(havingMemoId: selectedMemoId)
        navigationController?.pushViewController(writeMemoVC, animated: true)
    }
}
