//
//  CustomTabBarController.swift
//  QuickLink
//
//  Created by Tiger on 14/7/2.
//  Copyright (c) 2014年 Cao liu. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    var myTabbar :UIView?
    var slider :UIView?
    let btnBGColor:UIColor =  UIColor(red:125/255.0, green:236/255.0,blue:198/255.0,alpha: 1)
    let tabBarBGColor:UIColor =  UIColor(red:251/255.0, green:173/255.0,blue:69/255.0,alpha: 1)
    let titleColor:UIColor =  UIColor(red:52/255.0, green:156/255.0,blue:150/255.0,alpha: 1)

    let itemArray = ["拨打","联系人","设置"];
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initViews()
    }
    
    func initViews()
    {
        self.automaticallyAdjustsScrollViewInsets = false
        self.view!.backgroundColor = UIColor.whiteColor()
        self.tabBar.hidden = true
        var width = self.view.frame.size.width
        var height = self.view.frame.size.height
        self.myTabbar = UIView(frame: CGRectMake(0,height-49,width,49))
        self.myTabbar!.backgroundColor = tabBarBGColor
        self.slider = UIView(frame:CGRectMake(0,0,80,49))
        self.slider!.backgroundColor = UIColor.whiteColor()//btnBGColor
        self.myTabbar!.addSubview(self.slider)
        
        self.view.addSubview(self.myTabbar)
        
        var count = self.itemArray.count
        
        for var index = 0; index < count; index++
        {
            var btnWidth = (CGFloat)(index*80)
            var button  = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
            button.frame = CGRectMake(btnWidth, 0,80,49)
            button.tag = index+100
            var title = self.itemArray[index]
            button.setTitle(title, forState: UIControlState.Normal)
            button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            button.setTitleColor(tabBarBGColor, forState: UIControlState.Selected)
            
            button.addTarget(self, action: "tabBarButtonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
            self.myTabbar?.addSubview(button)
            if index == 0
            {
                button.selected = true
            }
        }
    }


}
