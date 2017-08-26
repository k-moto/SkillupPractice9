//
//  TweetItem.swift
//  SkillupPractice9
//
//  Created by k_motoyama on 2017/08/26.
//  Copyright © 2017年 k_moto. All rights reserved.
//

import Foundation
import ObjectMapper

struct TweetItem: Mappable {
    
    var userName = ""
    var screenName = ""
    var profileImageURL = ""
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        userName <- map["name"]
        screenName <- map["screen_name"]
        profileImageURL <- map["profile_image_url"]

    }
}
