//
//  APIClient.swift
//  SkillupPractice5
//
//  Created by k_motoyama on 2017/04/22.
//  Copyright © 2017年 k_moto. All rights reserved.
//

import Foundation
import Social
import Accounts


enum Path: String {
    case timeLine = "/home_timeline.json"
}

enum Result {
    case success(Any)
    case failure(Error)
}

class APIClient {
    
    let base = "https://api.twitter.com/1.1/statuses"
    var url: String
    var account: ACAccount
    var param: [AnyHashable : Any]!
    
    init(path: Path, account: ACAccount, param: [AnyHashable : Any]){
        url = base + path.rawValue
        self.account = account
        self.param = param
        
    }
    
    func request(completionHandler: @escaping (Result) -> Void = {_ in }) {
        
        let request = SLRequest(forServiceType: SLServiceTypeTwitter,
                                requestMethod: .GET,
                                url: URL(string: url),
                                parameters: nil)!
        request.account = account
        request.perform { (responseData, urlResponse, error) -> Void in
            
            if let error = error {
                completionHandler(Result.failure(error))
                
            } else {
                completionHandler(Result.success(responseData as Any))

            }
            
        }
        
    }
}
