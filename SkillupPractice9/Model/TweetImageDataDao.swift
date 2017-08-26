//
//  TweetImageDataDao.swift
//  SkillupPractice9
//
//  Created by k_motoyama on 2017/08/26.
//  Copyright © 2017年 k_moto. All rights reserved.
//

import Foundation
import RealmSwift

final class TweetImageDataDao {
    
    static let dao = RealmDaoHelper<TweetImageData>()
    
    static func add(model: TweetImageData) {
        
        let object = TweetImageData()
        object.id = TweetImageDataDao.dao.newId()!
        object.screenName = model.screenName
        object.profileImage = model.profileImage
        object.createDate = model.createDate
        
        TweetImageDataDao.dao.add(d: object)
    }
    
    static func update(model: TweetImageData) {
        
        guard let object = dao.findFirst(key: model.id as AnyObject) else {
            return
        }
        
        _ = dao.update(d: object,block:{() -> Void in
            object.screenName = model.screenName
            object.profileImage = model.profileImage
        })
        
        
    }
    
    static func delete(id: Int) {
        
        guard let object = dao.findFirst(key: id as AnyObject) else {
            return
        }
        dao.delete(d: object)
    }
    
    static func deleteAll() {
        dao.deleteAll()
    }
    
    static func findByID(id: Int) -> TweetImageData? {
        guard let object = dao.findFirst(key: id as AnyObject) else {
            return nil
        }
        return object
    }
    
    static func findFilter(predicate: NSPredicate) -> [TweetImageData]  {
        return dao.findFilter(predicate: predicate).map { TweetImageData(value: $0) }
        
    }
    
    static func findAll() -> [TweetImageData] {
        let objects =  TweetImageDataDao.dao.findAll()
        return objects.map { TweetImageData(value: $0) }
    }
}
