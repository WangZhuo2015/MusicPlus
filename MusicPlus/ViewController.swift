//
//  ViewController.swift
//  MusicPlus
//
//  Created by 王卓 on 15/12/8.
//  Copyright © 2015年 BubbleTeam. All rights reserved.
//

import UIKit
import MediaPlayer
import AVKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,HttpProtocol,channelProtocol {
    
    @IBOutlet weak var albumImg: AlbumImage!

    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var playBtn: Playbutton!
    
    @IBOutlet weak var preBtn: UIButton!
    
    @IBOutlet weak var backGroundImage: UIImageView!
    
    @IBOutlet weak var nextBtn: UIButton!
    
    @IBOutlet weak var channelBtn: UIButton!
    
    @IBOutlet weak var orderBtn: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var progress: UIImageView!
    var currIndex:Int = 0
    var timer = NSTimer()
    var mPlayer = MPMoviePlayerController()
    //var audioPlayer = AVPlayer()
    var imageCache = Dictionary <String,UIImage>()
    var tableViewDataArray = [JSON]()
    var channelArray = [JSON]()
    var eHttp = HTTPControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        //albumImg.onRotation()
        eHttp.delegate = self
        eHttp.onSearch("http://www.douban.com/j/app/radio/channels")
        eHttp.onSearch("http://douban.fm/j/mine/playlist?type=n&channel=0&from=mainsite")
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        albumImg.onRotation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewDataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("songsIdentlfier")
        if cell==nil{
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "songsIdentlfier")
        }
        let data = tableViewDataArray[indexPath.row]
        cell?.textLabel?.text = data["title"].string
        cell?.detailTextLabel?.text = data["artist"].string
        cell?.imageView?.image = getCacheImage(data["picture"].string!)
        return cell!
    }
    func didReceiveResult(result: AnyObject) {
        let json = JSON(data: result as! NSData)
        print(json)
        
        if let channel = json["channels"].array{
            channelArray = channel
            
        }else if let song  = json["song"].array{
            tableViewDataArray = song
            tableView.reloadData()
            onSelectedRow(0)
        }
    }
    func onChangeChannel(channelID:String){
        let url  = "http://douban.fm/j/mine/playlist?type=n&channel=\(channelID)&from=mainsite"
        eHttp.onSearch(url)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        onSelectedRow(indexPath.row)
    }
    
    func onSelectedRow(index:Int){
        let indexPath = NSIndexPath(forRow: index, inSection: 0)
        tableView.selectRowAtIndexPath(indexPath, animated: false, scrollPosition: UITableViewScrollPosition.Top)
        let data = tableViewDataArray[index] 
        let imageUrl  = data["picture"].stringValue
        let audioUrl  = data["url"].stringValue
        setImage(imageUrl)
        setOnAudio(audioUrl)
    }
    
    //设置cell的显示动画
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        //设置cell的显示动画为3d缩放，xy方向的缩放动画，初始值为0.1 结束值为1
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
        })
    }
    
    func setImage(url:String){
        let img = getCacheImage(url)
        albumImg.image = img
        backGroundImage.image = img
    }
    func setOnAudio(url:String){
        
        mPlayer.stop()
        mPlayer.contentURL = NSURL(string: url)
        mPlayer.play()
        playBtn.onPlay()
        
        timer.invalidate()
        timeLabel.text = "00:00"
        timer = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: Selector("onUpadte"), userInfo: nil, repeats: true)
        
    }
    func onUpadte(){
        let time = mPlayer.currentPlaybackTime
        if time>0.0 {
            
            //歌曲的总时间
            let t = mPlayer.duration
            
            //计算百分比
            let pro:CGFloat = CGFloat(time/t)
            //按百分比显示进度条的宽度
            progress.frame.size.width = view.frame.size.width * pro
            //这是一个小算法，来实现 00:00 这种样式的播放时间
            
            let all:Int = Int(time)
            let m:Int = all % 60
            let f:Int = Int(all/60)
            
            var time:String = ""
            if f<10 {
                time = "0\(f):"
            }else{
                time = "\(f):"
            }
            
            if m<10 {
                time+="0\(m)"
            }else{
                time+="\(m)"
            }
            //更新播放时间
            timeLabel.text = time
        }
    }
    func getCacheImage(url:String)->UIImage{
        if let img = imageCache[url]{
            return img
        }else{
        let img = UIImage(data: NSData(contentsOfURL: NSURL(string: url)!)!)
            imageCache[url] = img
            return img!
        }
    }
    
    @IBAction func onPlay(sender: Playbutton) {
        if sender.isPlay{
            mPlayer.pause()
        }else{
            mPlayer.play()
        }
    }

    @IBAction func preOrNext(sender: UIButton) {
        if sender === nextBtn{
            currIndex++
            if currIndex > tableViewDataArray.count-1{
                currIndex=0
            }
        }else{
            currIndex--
            if currIndex<0{
                currIndex = tableViewDataArray.count-1
            }
        }
        onSelectedRow(currIndex)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let VC = segue.destinationViewController as! ChannelViewController
        VC.delegate = self
        VC.dataArray = self.channelArray
    }

}

