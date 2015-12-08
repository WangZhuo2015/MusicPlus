//
//  AlbumImage.swift
//  MusicPlus
//
//  Created by 王卓 on 15/12/8.
//  Copyright © 2015年 BubbleTeam. All rights reserved.
//

import UIKit

class AlbumImage: UIImageView {
    required init!(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
            self.layer.cornerRadius = self.frame.size.width/2
            self.clipsToBounds = true
            self.layer.borderWidth = 4
            self.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7).CGColor
    }

    
    func onRotation(){
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.fromValue = 0
        animation.toValue = M_PI * 2
        animation.duration = 20
        animation.repeatCount = 10000
        self.layer.addAnimation(animation, forKey: nil)
    }

}
