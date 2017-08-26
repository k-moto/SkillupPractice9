//
//  TweetImageData.swift
//  SkillupPractice9
//
//  Created by k_motoyama on 2017/08/26.
//  Copyright © 2017年 k_moto. All rights reserved.
//

import Foundation
import STV_Extensions
import RealmSwift

class TweetImageData: Object {
    
    dynamic var id = 0
    dynamic var screenName = ""
    dynamic var profileImage = ""
    dynamic var createDate = Date()
    
    override static func primaryKey() -> String? {
        return "id"
        
    }
}
