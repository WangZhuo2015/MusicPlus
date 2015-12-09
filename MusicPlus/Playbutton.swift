//
//  Playbutton.swift
//  MusicPlus
//
//  Created by 王卓 on 15/12/9.
//  Copyright © 2015年 BubbleTeam. All rights reserved.
//

import UIKit

class Playbutton: UIButton {
    var isPlay:Bool = true
    let imgPlay:UIImage = UIImage(named: "play")!
    let imgPause:UIImage = UIImage(named: "pause")!
        
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.addTarget(self, action: "onClick", forControlEvents:UIControlEvents.TouchUpInside)
    }
    func onClick(){
        isPlay = !isPlay
        if isPlay{
            self.setImage(imgPause, forState: UIControlState.Normal)
        }else{
            self.setImage(imgPlay, forState: UIControlState.Normal)
        }
    }
    func onPlay(){
        isPlay = true
        self.setImage(imgPause, forState: UIControlState.Normal)
    }
    
}
