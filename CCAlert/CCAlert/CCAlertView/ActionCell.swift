//
//  ActionCell.swift
//  Artden
//
//  Created by CC.Bai on 16/8/26.
//  Copyright © 2016年 pan. All rights reserved.
//

import UIKit

enum CCActionType {
    case TopCorner
    case RoundCorner
    case BottomCorner
    case NoCorner
}

class ActionCell: UICollectionViewCell {
    
    
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellTitleLbl: UILabel!
    
    private let screenWidth:CGFloat = UIScreen.mainScreen().bounds.size.width
    private let screenHeight:CGFloat = UIScreen.mainScreen().bounds.size.height
    
    var cellType:CCActionType{
        set{
            setCellCorner(newValue)
        }
        get{
            return self.cellType
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
//        setCellCorner(CCActionType.TopCorner)
    }
    
    func setCellCorner(type:CCActionType){
        cellImageView.image = UIImage.init(named: "cc_action_cell")
        var bounds = self.bounds
        bounds.size.width = screenWidth - 14*2
        var maskPath:UIBezierPath
        switch type {
        case .TopCorner:
            maskPath = UIBezierPath.init(roundedRect: bounds, byRoundingCorners: [UIRectCorner.TopRight,UIRectCorner.TopLeft], cornerRadii: CGSizeMake(17, 17))
        case .BottomCorner:
            maskPath = UIBezierPath.init(roundedRect: bounds, byRoundingCorners: [UIRectCorner.BottomRight,UIRectCorner.BottomLeft], cornerRadii: CGSizeMake(17, 17))
        case .RoundCorner:
            maskPath = UIBezierPath.init(roundedRect: bounds, byRoundingCorners: UIRectCorner.AllCorners, cornerRadii: CGSizeMake(17, 17))
        default:
            maskPath = UIBezierPath.init(rect: bounds)
        }
        let maskLayer = CAShapeLayer.init()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.CGPath
        cellImageView.layer.mask = maskLayer
        
    }

}
