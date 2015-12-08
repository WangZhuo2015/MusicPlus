//
//  ViewController.swift
//  MusicPlus
//
//  Created by 王卓 on 15/12/8.
//  Copyright © 2015年 BubbleTeam. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var albumImg: AlbumImage!

    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var playBtn: UIButton!
    
    @IBOutlet weak var preBtn: UIButton!
    
    @IBOutlet weak var nextBtn: UIButton!
    
    @IBOutlet weak var channelBtn: UIButton!
    
    @IBOutlet weak var orderBtn: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        albumImg.onRotation()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("songsIdentlfier")
        if cell==nil{
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "songsIdentlfier")
        }
        
        
        return cell!
    }
    

}

