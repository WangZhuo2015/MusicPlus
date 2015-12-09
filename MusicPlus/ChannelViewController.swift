//
//  ChannelViewController.swift
//  MusicPlus
//
//  Created by 王卓 on 15/12/9.
//  Copyright © 2015年 BubbleTeam. All rights reserved.
//

import UIKit

protocol channelProtocol{
    func onChangeChannel(channelID:String)
}

class ChannelViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var backBtn: UIButton!
    var delegate:channelProtocol?
    
    
    @IBOutlet weak var tableView: UITableView!
    var dataArray = [JSON]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    @IBAction func backToMain(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("songsIdentlfier")
        if cell==nil{
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "songsIdentlfier")
        }
        let data = dataArray[indexPath.row] as JSON
        cell?.textLabel?.text = data["name"].string
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let rowData = dataArray[indexPath.row] as JSON
        let  id = rowData["channel_id"].stringValue
        delegate?.onChangeChannel(id)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
