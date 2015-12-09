//
//  HTTPControl.swift
//  MusicPlus
//
//  Created by 王卓 on 15/12/9.
//  Copyright © 2015年 BubbleTeam. All rights reserved.
//

import UIKit
import Alamofire
class HTTPControl{
    var delegate:HttpProtocol?
    func onSearch(url:String){
        Alamofire.request(.GET, url).responseJSON(options: NSJSONReadingOptions.MutableContainers) { (result) -> Void in
            self.delegate?.didReceiveResult(result.data!)
        }
    }
}

protocol HttpProtocol{
    func didReceiveResult(result:AnyObject)
}
