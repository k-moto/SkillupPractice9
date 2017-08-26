//
//  TweetListCell.swift
//  SkillupPractice9
//
//  Created by k_motoyama on 2017/08/26.
//  Copyright © 2017年 k_moto. All rights reserved.
//

import UIKit
import Foundation

final class TweetListCell: UITableViewCell {
    
    @IBOutlet weak var thumbImage: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var tweetText: UILabel!
    
    static var identifier: String {
        get {
            return String(describing: self)
        }
    }
    
    var tweetData: TweetResult? {
        didSet {
            
            let screenNameData = tweetData?.user?.screenName ?? ""
            
            let predicate = NSPredicate(format: "screenName == %@", screenNameData)
            let findImage = TweetImageDataDao.findFilter(predicate: predicate)
            
            var dispImage: UIImage = UIImage()
            
            if findImage.count > 0 {
                let imageData = findImage[0].profileImage.replacingOccurrences(of: "data:image/png;base64,", with: "")
                dispImage = imageData.base64Decode(imageString: imageData)!
                
            } else {
                
                do {
                    
                    if let urlString = tweetData?.user?.profileImageURL {
                        let imageURL = URL(string: urlString)
                        let imageData = try Data(contentsOf: imageURL!)
                        dispImage = UIImage(data: imageData)!
                        
                        let addData = TweetImageData()
                        addData.screenName = screenNameData
                        addData.profileImage = dispImage.base64Encode(format: .png)!
                        addData.createDate = Date()
                        TweetImageDataDao.add(model: addData)

                        
                    }
                } catch {
                    print("failed to append: \(error.localizedDescription)")
                    
                }
            }
            
            thumbImage.image = dispImage
            
            userName.text = tweetData?.user?.userName
            screenName.text = screenNameData
            tweetText.text = tweetData?.tweetText
            
        }
    }
}
