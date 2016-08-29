//
//  CCAlertSheetView.swift
//  Artden
//
//  Created by CC.Bai on 16/8/26.
//  Copyright © 2016年 pan. All rights reserved.
//

import UIKit

typealias CCActionClosure = ()->Void

class CCAlertSheetView: UIView,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var actionColView: UICollectionView!
    @IBOutlet weak var sheetView: UIView!
    
    @IBOutlet weak var actionViewHeightConstrain: NSLayoutConstraint!
    @IBOutlet weak var viewBottomConstraint: NSLayoutConstraint!
    
    private let actionArray:NSMutableArray = NSMutableArray.init(capacity: 1)
    private let actionCell = "ActionCell"
    private let flowLayout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    
    private let miniSheetHeight:CGFloat = 65
    private let actionCellHeight:CGFloat = 52
    private let screenWidth:CGFloat = UIScreen.mainScreen().bounds.size.width
    private let screenHeight:CGFloat = UIScreen.mainScreen().bounds.size.height
    
    class func instanceAlertView() -> CCAlertSheetView {
        let nibView:NSArray = NSBundle.mainBundle().loadNibNamed("CCAlertSheetView", owner: nil, options: nil)
        return (nibView.objectAtIndex(0) as? CCAlertSheetView)!
    }
    
    func initializeView(){
        self.cancelBtn.layer.cornerRadius = 17
        self.cancelBtn.layer.masksToBounds = true
        actionColView.delegate = self
        actionColView.dataSource = self
        actionColView.collectionViewLayout = flowLayout
        let cellNib = UINib.init(nibName: "ActionCell", bundle: nil)
        actionColView.registerNib(cellNib, forCellWithReuseIdentifier: actionCell)
        self.frame = CGRectMake(0, 0, screenWidth, screenHeight)
        
        actionViewHeightConstrain.constant = miniSheetHeight
        self.updateConstraintsIfNeeded()
        
//        let tapGesutre = UITapGestureRecognizer.init(target: self, action: #selector(cancelBtnAction))
//        self.addGestureRecognizer(tapGesutre)
        
        self.addObserver(self, forKeyPath: "hidden", options: NSKeyValueObservingOptions.New, context: nil)
    }
    
    //显示动画
    func animateShowSheet(){
        viewBottomConstraint.constant = 0
        UIView.animateWithDuration(0.2) { [weak self]()in
            self!.updateConstraintsIfNeeded()
        }
    }
    
    func animateHideSheet(){
        viewBottomConstraint.constant = -miniSheetHeight - CGFloat(actionArray.count) * (actionCellHeight + 1)
        UIView.animateWithDuration(0.2, animations: { [weak self] () in
            self!.layoutIfNeeded()
            }) { [weak self](finished) in
                if finished{
                    self!.hidden = true
                }
        }
    }
    
    //添加动作
    func addAction(title:String,color:UIColor = UIColor.redColor(),font:UIFont = UIFont.systemFontOfSize(17),action:CCActionClosure?,type:CCActionType){
        let model = CCActionModel()
        model.title = title
        model.titleColor = color
        model.titleFont = font
        model.actionType = type
        if action != nil{
            model.action = action
        }
        actionArray.addObject(model)
        actionViewHeightConstrain.constant = miniSheetHeight + CGFloat(actionArray.count)*actionCellHeight + CGFloat(actionArray.count - 1)
        viewBottomConstraint.constant = -actionViewHeightConstrain.constant
        self.updateConstraintsIfNeeded()
        self.actionColView.reloadData()
    }
    
    //collection delegate
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return actionArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(actionCell, forIndexPath: indexPath) as! ActionCell
        let model = actionArray.objectAtIndex(indexPath.row) as! CCActionModel
        cell.cellTitleLbl.text = model.title
        cell.cellType = model.actionType
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let model = actionArray.objectAtIndex(indexPath.row) as! CCActionModel
        let action = model.action
        if action != nil{
            action!()
        }
        self.animateHideSheet()
    }
    
    //layout delegate
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(screenWidth - 14*2, actionCellHeight)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsZero
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1
    }
    
    
    //kvo 方法
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "hidden"{
            if let new = change!["new"]{
                let state = new as! NSInteger
                if state == 0{
                    self.animateShowSheet()
                }
            }
        }
    }
    
    //touch 方法改写
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first
        if touch?.tapCount == 1{
            self.animateHideSheet()
        }
    }
    
    @IBAction func cancelBtnAction(sender: UIButton) {
        self.animateHideSheet()
    }
    
    deinit{
        self.removeObserver(self, forKeyPath: "hidden")
    }
    
}

class CCActionModel:NSObject{
    var actionType:CCActionType = CCActionType.RoundCorner
    var title:String = ""
    var action:CCActionClosure? = nil
    var titleFont:UIFont = UIFont.systemFontOfSize(17)
    var titleColor:UIColor = UIColor.redColor()
}
