# CCAlertView
iOS ActionSheet view

项目中经常会用到iOS的actionsheet弹出页面，但是自8.0之后定制样式十分麻烦，UI那边又频繁改动，所以个人重写了一个

CCAlertView是以UICollectionView的形式实现的
------------------
首先实例化一个alertView

let sheetView = CCAlertSheetView.instanceAlertView()

并初始化它 sheetView.initializeView()

项目中设置了对sheetView的hidden属性键值观察，动画弹出的效果也是据此调用。

添加sheetView到当前页面 

view.addSubview(sheetView)

并设置hidden属性为true

接着就可以像使用系统样式添加事件一样为sheetView添加事件了，在添加的同时，你可以设置每个事件按钮的标题样式（包括字号，字体，颜色，以及按钮的圆角类型），圆角类型包括：
>顶部圆角   CCActionType.TopCorner , 

>全部圆角    CCActionType.RoundCorner  , 

>底部圆角 CCActionType.BottomCorner 

>无圆角 CCActionType.NoCorner

例如 ：

	sheetAlert.addAction("Action", action: {
            print("Alert view - 1 - action")
            }, type: CCActionType.RoundCorner)

            
            
或者

	sheetAlert.addAction("Action", color: 	   UIColor.cyanColor(), font: UIFont(name: "PingFangSC-Regular",size: 17)!, action: { 
            print("Alert view - 1- action")
            }, type: CCActionType.RoundCorner)


            
##需要显示sheetView的时候只需要设置它的hidden属性为false即可
           

            
            