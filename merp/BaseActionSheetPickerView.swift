//
//  BaseActionSheetPickerView.swift
//  BLActionPickerView
//
//  Created by yunjie Xie on 15/11/25.
//  Copyright © 2015年 balintimes. All rights reserved.
//

import Foundation
import UIKit

class BaseActionSheetPickerView:AbstractActionSheetPicker, UIPickerViewDelegate,UIPickerViewDataSource{
    
    var parentController:UIViewController?;
    
    var doneFn:((BaseActionSheetPickerView,[Int:Int])->Void)?;
    var cancelFn:((BaseActionSheetPickerView)->Void)?;
    
//    func getPicker() -> UIPickerView{
//        
//        let picker = self.pickerView as! UIPickerView;
//        return picker;
//    }
    
    var basePickerView:UIPickerView{
        get{
            let picker = self.pickerView as! UIPickerView;
            return picker;
        }
    }
    
//    init(title:String,origin: AnyObject!) {
//        super.init(target: nil, successAction: nil, cancelAction: nil, origin: origin);
//
//    }
//    
//    init(origin: AnyObject!,doneTitle:String = "完成", cancelTitle:String = "取消",pickerTitle:String = "") {
//        
//        super.init(target: nil, successAction: nil, cancelAction: nil, origin: origin);
//        
////        let okButton = UIButton(type: .Custom);
////        okButton.setTitle(doneTitle, forState: .Normal);
////        okButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal);
////        okButton.setTitleColor(UIColor.redColor(), forState: UIControlState.Highlighted);
////        okButton.frame = CGRectMake(0, 0, 45, 32);
////        self.setDoneButton(UIBarButtonItem(customView: okButton));
////        
////        
////        let cancelButton = UIButton(type: .Custom);
////        cancelButton.setTitle(cancelTitle, forState: .Normal);
////        cancelButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal);
////        cancelButton.setTitleColor(UIColor.redColor(), forState: UIControlState.Highlighted);
////        cancelButton.frame = CGRectMake(0, 0, 45, 32);
////        self.setCancelButton(UIBarButtonItem(customView: cancelButton));
////        
////        self.title = pickerTitle;
//    }
    
    func setDefaultBottons(doneTitle:String = "完成",cancelTitle:String = "取消",pickerTitle:String = ""){
                let okButton = UIButton(type: .Custom);
                okButton.setTitle(doneTitle, forState: .Normal);
                okButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal);
                okButton.setTitleColor(UIColor.redColor(), forState: UIControlState.Highlighted);
                okButton.frame = CGRectMake(0, 0, 45, 32);
                self.setDoneButton(UIBarButtonItem(customView: okButton));
        
        
                let cancelButton = UIButton(type: .Custom);
                cancelButton.setTitle(cancelTitle, forState: .Normal);
                cancelButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal);
                cancelButton.setTitleColor(UIColor.redColor(), forState: UIControlState.Highlighted);
                cancelButton.frame = CGRectMake(0, 0, 45, 32);
                self.setCancelButton(UIBarButtonItem(customView: cancelButton));
                
                self.title = pickerTitle;
    }
    
//    class func create(controller controller:UIViewController, successAction:((BaseActionSheetPickerView,[Int:Int])->Void)!,cancelAction:((BaseActionSheetPickerView)->Void)!,origin:AnyObject!) -> BaseActionSheetPickerView{
//        
//        let picker = BaseActionSheetPickerView(target: nil, successAction: nil, cancelAction: nil, origin: origin);
//        
//        picker.doneFn = successAction;
//        picker.cancelFn = cancelAction;
//        picker.parentController = controller;
//        
//        let okButton = UIButton(type: .Custom);
//        okButton.setTitle("完成", forState: .Normal);
//        okButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal);
//        okButton.setTitleColor(UIColor.redColor(), forState: UIControlState.Highlighted);
//        okButton.frame = CGRectMake(0, 0, 45, 32);
//        picker.setDoneButton(UIBarButtonItem(customView: okButton));
//        
//        
//        let cancelButton = UIButton(type: .Custom);
//        cancelButton.setTitle("取消", forState: .Normal);
//        cancelButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal);
//        cancelButton.setTitleColor(UIColor.redColor(), forState: UIControlState.Highlighted);
//        cancelButton.frame = CGRectMake(0, 0, 45, 32);
//        picker.setCancelButton(UIBarButtonItem(customView: cancelButton));
//        
//        return picker;
//    }
    
    override func configuredPickerView() -> UIView! {
        
        let picker = UIPickerView(frame: CGRectMake(0, 40, self.viewSize.width, 216));
        picker.delegate = self;
        picker.dataSource = self;
        
        picker.showsSelectionIndicator = true;
        picker.userInteractionEnabled = true;
        picker.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.2);
        self.pickerView = picker;
        return picker;
    }
    
    override func notifyTarget(target: AnyObject!, didCancelWithAction cancelAction: Selector, origin: AnyObject!) {
        if let cancel = self.cancelFn{
            cancel(self);
        }
        
    }
    override func notifyTarget(target: AnyObject!, didSucceedWithAction successAction: Selector, origin: AnyObject!) {
        
        if let done = self.doneFn{
            let picker = self.pickerView as! UIPickerView;
            var dicResult = Dictionary<Int,Int>();
            for index in 0...(picker.numberOfComponents - 1){
                dicResult[index] = picker.selectedRowInComponent(index);
            }
            done(self, dicResult);
        }
    }
    
    
    // DataSourceDelegate
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        return 1;
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return 0;
    }
}