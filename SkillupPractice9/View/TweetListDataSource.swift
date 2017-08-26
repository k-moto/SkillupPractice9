//
//  TweetListDataSource.swift
//  SkillupPractice9
//
//  Created by k_motoyama on 2017/08/26.
//  Copyright © 2017年 k_moto. All rights reserved.
//

import UIKit

class TweetListDataSource: NSObject, UITableViewDataSource {
    
    var dataList: [TweetResult] = []
    let dispDateFormat = "yyyy-MM-dd"
    
    func add(dataList: [TweetResult]){
        self.dataList = dataList
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TweetListCell.identifier,for: indexPath) as! TweetListCell
        cell.tweetData = dataList[indexPath.row]
        
        return cell
    }
    
}
