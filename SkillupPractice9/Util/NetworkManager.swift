//
//  NetworkManager.swift
//  SkillupPractice5
//
//  Created by k_motoyama on 2017/04/22.
//  Copyright © 2017年 k_moto. All rights reserved.
//

import Foundation
import Alamofire

final class NetworkManager {
    
    static func isAvailable() -> Bool{
        
        let net = NetworkReachabilityManager()
        net?.startListening()
        
        if net?.isReachable ?? false {
            return true
            
        } else {
            return false
        }
    }
}
