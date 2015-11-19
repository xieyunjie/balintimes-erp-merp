//
//  ErpListViewHeader.swift
//  merp
//
//  Created by yunjie Xie on 15/11/19.
//  Copyright © 2015年 balintimes. All rights reserved.
//

import UIKit

protocol ErpListViewHeaderDelegate:NSObjectProtocol{
    func HeaderOnClick(sender:ErpListViewHeader,group:UserModelGroup);
}

class ErpListViewHeader: UICollectionReusableView {
    
    @IBOutlet var btnGroup: UIButton!

    @IBOutlet var lblCount: UILabel!
    
    private var _userGroup:UserModelGroup?;
    
    var delegate:ErpListViewHeaderDelegate?;
    
    var userGroup:UserModelGroup?{
        set(value){
            
            self._userGroup = value!;
            
            self.btnGroup.setTitle(self._userGroup?.name, forState: UIControlState.Normal);
            self.lblCount.text = "\(self.userGroup?.models?.count) 项";
            
            btnGroup.imageView?.contentMode = UIViewContentMode.Center;
            btnGroup.imageView?.clipsToBounds = false;
            
            if self._userGroup?.visible == true{
                self.btnGroup.imageView?.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2));
            }
            else{
                self.btnGroup.imageView?.transform = CGAffineTransformMakeRotation(0);
            }
            
        }
        get{
            return self._userGroup;
        }
    };
    
    @IBAction func btnGroupClick(sender: AnyObject) {
        if let dlg = self.delegate{
            dlg.HeaderOnClick(self, group: self._userGroup!);
        }
    }
    
}
