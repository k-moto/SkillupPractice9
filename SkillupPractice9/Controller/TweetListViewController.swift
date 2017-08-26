//
//  TweetListViewController.swift
//  SkillupPractice9
//
//  Created by k_motoyama on 2017/08/26.
//  Copyright © 2017年 k_moto. All rights reserved.
//

import UIKit
import Accounts

class TweetListViewController: UIViewController {
    
    let tweetAPI = TweetAPI()
    let tweetListDataSource = TweetListDataSource()
    var account:ACAccount!
    let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var tweetTable: UITableView!
    
    @IBOutlet weak var indicatorView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicatorView.isHidden = false
        
        tweetTable.dataSource = tweetListDataSource
        tweetTable.estimatedRowHeight = 44
        tweetTable.rowHeight = UITableViewAutomaticDimension
        
        
        tweetTable.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        
        checkAccountAccess()
        
        tweetAPI.loadable = self
        
    }
    
    func refresh(sender: UIRefreshControl) {
        indicatorView.isHidden = false
        self.tweetAPI.fetch(account: account)

    }
    
    func checkAccountAccess() {
        let accountStore = ACAccountStore()
        let accountType = accountStore.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter)
        
        accountStore.requestAccessToAccounts(with: accountType, options: nil) {
            (granted: Bool, error: Error?) -> Void in
            if error != nil {
                // エラー処理
                print(error)
                return
            }
            
            if !granted {
                print("Twitterアカウントの利用未許可")
                return
            }
            
            let accounts = accountStore.accounts(with: accountType) as! [ACAccount]
            if accounts.count == 0 {
                print("アカウント未設定")
                return
            }
            
            // TODO: アカウントの選択させる？
            self.account = accounts[0]
            self.tweetAPI.fetch(account: self.account)
        }
    }
}

extension TweetListViewController: TweetLoadable {
    
    func setResult(result: TweetStatus) {
        DispatchQueue.main.async {
            
            self.indicatorView.isHidden = true
            switch result {
                
            case .none:
                self.showAlert(title: "データ無し", message: "データが存在しません。")
                
            case .nomal(let result):
                self.tweetListDataSource.add(dataList: result)
                self.tweetTable.reloadData()
                self.tweetTable.reloadData()

            case .noData:
                self.showAlert(title: "データ無し", message: "データが存在しません。")
                
            case .error(let error):
                self.showAlert(title: "エラー", message: "何らかのエラーが発生しました。")
                
                print("error: \(error)")
            }
        }
        self.refreshControl.endRefreshing()
    }
    
    private func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        
    }
    
}

