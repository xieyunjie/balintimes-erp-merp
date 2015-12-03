//
//  DataPickerViewController.swift
//  merp
//
//  Created by yunjie Xie on 15/12/1.
//  Copyright © 2015年 balintimes. All rights reserved.
//

import UIKit

@objc
protocol DataPickerViewControllerDelegate{
    
    func pickerDone();
    
    optional func pickerCancel();
    optional func pickerShowCompletion(finish:Bool);
}

enum DataPickerViewControllerNotification:String {
    
    case PickerShowBeginNotification = "PickerShowBeginNotification",PickerShowEndNotification = "PickerShowEndNotification",
    PickerHideBeginNotification = "PickerHideBeginNotification",PickerHideEndNotification = "PickerHideEndNotification";
    
    case PickerHeightKey = "PickerHeightKey",PickerAnimateDuration = "PickerAnimateDuration",PickerDelay = "PickerDelay";
}

class DataPickerViewController: UIViewController{
    
    @IBOutlet weak var containerTopC: NSLayoutConstraint!
    var viewTopC:NSLayoutConstraint?;
    
    @IBOutlet weak var containerView: UIView!;
    @IBOutlet weak var dataPicker: UIPickerView!
    @IBOutlet weak var navItem: UINavigationItem!
    
    var delegate:DataPickerViewControllerDelegate?;
    private var notificationCenter:NSNotificationCenter;
    
    private let animateDuration = 0.25,animateDelay = 0.25;
    
    var sender:AnyObject?;
    
    init(){
        let resourcesBundle = NSBundle(forClass:DataPickerViewController.self)
        self.notificationCenter = NSNotificationCenter.defaultCenter();
        super.init(nibName: "DataPickerViewController", bundle: resourcesBundle)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    final func show(parent:UIViewController,sender:AnyObject){
        
        if self.view.superview == nil{
            self.view.translatesAutoresizingMaskIntoConstraints = false;
            parent.view.addSubview(self.view);
            
            let superView = self.view.superview!,view = self.view;
            
            viewTopC = NSLayoutConstraint(item: view, attribute: .Top, relatedBy: .Equal, toItem: superView, attribute: .Top, multiplier: 1, constant: 0);
            let viewBottomC = NSLayoutConstraint(item: view, attribute: .Bottom, relatedBy: .Equal, toItem: superView, attribute: .Bottom, multiplier: 1, constant: 0);
            let viewLeftC =  NSLayoutConstraint(item: view, attribute: .Left, relatedBy: .Equal, toItem: superView, attribute: .Left, multiplier: 1, constant: 0);
            let viewRightC =  NSLayoutConstraint(item: view, attribute: .Right, relatedBy: .Equal, toItem: superView, attribute: .Right, multiplier: 1, constant: 0);
            
            superView.addConstraints([viewTopC!,viewBottomC,viewLeftC,viewRightC]);
            
            self.containerTopC.constant = superView.frame.height;
            self.containerView.layoutIfNeeded();
        }else{
            self.viewTopC?.constant = 0;
            self.view.superview?.layoutIfNeeded();
        }
        
        self.sender =  sender;
        
        var userInfo:[NSObject:AnyObject] = [DataPickerViewControllerNotification.PickerAnimateDuration.rawValue:self.animateDuration,
            DataPickerViewControllerNotification.PickerDelay.rawValue:self.animateDelay,
            DataPickerViewControllerNotification.PickerHeightKey.rawValue:CGFloat(0) ];
        
        
        self.notificationCenter.postNotificationName(DataPickerViewControllerNotification.PickerShowBeginNotification.rawValue, object: self, userInfo: userInfo);
        
        UIView.animateWithDuration(self.animateDuration, delay: self.animateDelay, options: .CurveEaseInOut, animations: { () -> Void in
            
            self.containerTopC.constant = self.view.superview!.frame.height - self.containerView.frame.height;
            self.view.layoutIfNeeded()
            
            }) {(finish) -> Void in
                
                userInfo[DataPickerViewControllerNotification.PickerHeightKey.rawValue] = CGFloat(self.containerView.frame.height);
                
                 self.notificationCenter.postNotificationName(DataPickerViewControllerNotification.PickerShowEndNotification.rawValue, object: self, userInfo: userInfo);
                
                
                if let d = self.delegate?.pickerShowCompletion{
                    d(finish);
                }
        }
        
    }
    
   final func hide(){
        
        var userInfo:[NSObject:AnyObject] = [DataPickerViewControllerNotification.PickerAnimateDuration.rawValue:self.animateDuration,
            DataPickerViewControllerNotification.PickerDelay.rawValue:self.animateDelay,
            DataPickerViewControllerNotification.PickerHeightKey.rawValue:CGFloat(self.containerView.frame.height) ];
        
        self.notificationCenter.postNotificationName(DataPickerViewControllerNotification.PickerHideBeginNotification.rawValue, object: self, userInfo: userInfo);
        UIView.animateWithDuration(self.animateDuration, delay: self.animateDelay, options: .CurveEaseInOut, animations: { () -> Void in
            
            self.containerTopC.constant = self.view.superview!.frame.height;
            self.containerView.layoutIfNeeded();
            }) { (bool) -> Void in
                 userInfo[DataPickerViewControllerNotification.PickerHeightKey.rawValue] = CGFloat(0);
                self.notificationCenter.postNotificationName(DataPickerViewControllerNotification.PickerHideEndNotification.rawValue, object: self, userInfo: userInfo);
                
                self.viewTopC?.constant = self.view.superview!.frame.height;
        }
        
    }
    
    @IBAction final func btnCancelClick(sender: AnyObject) {
        if let cancel = self.delegate?.pickerCancel{
            cancel();
        }
        
        self.hide();
    }
    
    @IBAction final func btnDoneClick(sender: AnyObject) {
        if let d = self.delegate{
            d.pickerDone();
        }
        self.hide();
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
