//
//  TweetAPI.swift
//  SkillupPractice9
//
//  Created by k_motoyama on 2017/08/26.
//  Copyright © 2017年 k_moto. All rights reserved.
//

import Foundation
import ObjectMapper
import Accounts

final class TweetAPI {
    
    var loadable: TweetLoadable?
    
    func fetch(account: ACAccount) {
        
        var getParam:[AnyHashable : Any] = [:]
        getParam["count"] = "20"

        guard NetworkManager.isAvailable() else {
            let error = NSError.init(domain: "", code: 500, userInfo: nil)
            self.loadable?.setResult(result: .error(error))
            return
        }
        
        let client = APIClient(path: .timeLine, account: account, param: getParam)
        
        client.request() { [weak self] (response) in
            
            switch response {
            case .success(let result) :
                
                do{
                    let jsonResults = try JSONSerialization.jsonObject(with: result as! Data) as! NSArray
                    
                    var resultDatas:[TweetResult] = []
                    
                    for result in jsonResults {
                        if let searchResult = Mapper<TweetResult>().map(JSONObject: result) {
                            resultDatas.append(searchResult)
                            
                        }
                    }
                    
                    if let result = self?.setResult(result: resultDatas) {
                        self?.loadable?.setResult(result: result)
                        
                    }
                    
                } catch {
                    self?.loadable?.setResult(result: .error(error))
                    
                }
                
            case .failure(let error):
                self?.loadable?.setResult(result: .error(error))
            }
        }
    }
    
    private func setResult(result: [TweetResult]) -> TweetStatus {
        return result.count <= 0 ? .noData : .nomal(result)
    }
}
