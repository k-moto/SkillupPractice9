//
//  TweetStatus.swift
//  SkillupPractice9
//
//  Created by k_motoyama on 2017/08/26.
//  Copyright © 2017年 k_moto. All rights reserved.
//


import Foundation

enum TweetStatus {
    case none
    case nomal([TweetResult])
    case noData
    case error(Error)
}

protocol TweetLoadable {
    func setResult(result: TweetStatus)
}
