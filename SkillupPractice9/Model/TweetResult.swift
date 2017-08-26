//
//  TweetResult.swift
//  SkillupPractice9
//
//  Created by k_motoyama on 2017/08/26.
//  Copyright © 2017年 k_moto. All rights reserved.
//

import Foundation
import ObjectMapper

struct TweetResult: Mappable {
    
    var user: TweetItem? = nil
    var tweetText = ""

    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        user <- map["user"]
        tweetText <- map["text"]
        
    }
}
