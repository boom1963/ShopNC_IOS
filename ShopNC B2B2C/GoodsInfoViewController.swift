//
//  GoodsInfoViewController.swift
//  ShopNC B2B2C
//
//  Created by lzp on 14/11/12.
//  Copyright (c) 2014年 ShopNC. All rights reserved.
//

import UIKit

class GoodsInfoViewController: UIViewController, UIWebViewDelegate {
    var goods_id = ""
    var mobile_body = ""
    var webview = UIWebView()
    var activity: UIActivityIndicatorView!
    var modebtn = UIButton()
    var mode = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "图文详情"
        modebtn.frame.size = CGSizeMake(30, 30)
        modebtn.addTarget(self, action: "changemode", forControlEvents: UIControlEvents.TouchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: modebtn)
        activity = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        activity.center = CGPointMake(self.view.frame.width/2, self.view.frame.height/2)
        activity.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        self.view.addSubview(activity)
        webview.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height-64)
        webview.scalesPageToFit = true
        self.view.addSubview(webview)
        if mobile_body != "" {//手机版图文详情
            modebtn.setBackgroundImage(UIImage(named: "iphone.png"), forState: UIControlState.Normal)
            mode = "iphone"
            webview.loadHTMLString(mobile_body, baseURL: nil)
        } else {//电脑版图文详情
            modebtn.setBackgroundImage(UIImage(named: "computer.png"), forState: UIControlState.Normal)
            mode = "computer"
            let url = NSURL(string: API_URL + "index.php?act=goods&op=goods_body&goods_id=" + goods_id)
            let request = NSURLRequest(URL: url!)
            webview.loadRequest(request)
        }
    }
    
    /**设置顶部状态栏**/
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return false
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setNeedsStatusBarAppearanceUpdate()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 208/255, green: 31/255, blue: 0/255, alpha: 1.0)
        self.navigationController?.navigationBar.barStyle = UIBarStyle.BlackTranslucent
        UIView.setAnimationsEnabled(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /**切换显示模式**/
    func changemode() {
        if mode == "computer" {
            modebtn.setBackgroundImage(UIImage(named: "iphone.png"), forState: UIControlState.Normal)
            mode = "iphone"
            webview.loadHTMLString(mobile_body, baseURL: nil)
        } else {
            modebtn.setBackgroundImage(UIImage(named: "computer.png"), forState: UIControlState.Normal)
            mode = "computer"
            let url = NSURL(string: API_URL + "index.php?act=goods&op=goods_body&goods_id=" + goods_id)
            let request = NSURLRequest(URL: url!)
            webview.loadRequest(request)
        }
    }
    
    /**webview的加载设置**/
    func webViewDidStartLoad(webView: UIWebView) {
        activity.startAnimating()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        activity.stopAnimating()
    }
}