//
//  ViewController.swift
//  CCAlert
//
//  Created by CC.Bai on 16/8/29.
//  Copyright © 2016年 ARTDEN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var alertView1:CCAlertSheetView? = nil
    private var alertView2:CCAlertSheetView? = nil
    private var alertView3:CCAlertSheetView? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        alertView1 = CCAlertSheetView.instanceAlertView()
        alertView1!.initializeView()
        alertView1!.addAction("Action", action: {
            print("Alert view - 1 - action")
            }, type: CCActionType.RoundCorner)
        view.addSubview(alertView1!)
        alertView1?.hidden = true
        
        alertView2 = CCAlertSheetView.instanceAlertView()
        alertView2!.initializeView()
        alertView2!.addAction("Action - 1 -", action: {
            print("Alert view - 2 - action - 1 -")
            }, type: CCActionType.TopCorner)
        alertView2!.addAction("Action - 2 -", action: {
            print("Alert view - 2 - action - 2 -")
            }, type: CCActionType.BottomCorner)
        view.addSubview(alertView2!)
        alertView2?.hidden = true
        
        alertView3 = CCAlertSheetView.instanceAlertView()
        alertView3!.initializeView()
        alertView3!.addAction("Action - 1 -", action: {
            print("Alert view - 3 - action - 1 -")
            }, type: CCActionType.TopCorner)
        alertView3!.addAction("Action - 2 -", action: {
            print("Alert view - 3 - action - 2 -")
            }, type: CCActionType.NoCorner)
        alertView3!.addAction("Action - 3 -", action: {
            print("Alert view - 3 - action - 3 -")
            }, type: CCActionType.BottomCorner)
        view.addSubview(alertView3!)
        alertView3?.hidden = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func style1Action(sender: UIButton) {
        alertView1?.hidden = false
    }

    @IBAction func style2Action(sender: UIButton) {
        alertView2?.hidden = false
    }
    
    @IBAction func style3Action(sender: UIButton) {
        alertView3?.hidden = false
    }

}

