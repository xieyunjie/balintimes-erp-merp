//
//  CityPickerViewController.swift
//  merp
//
//  Created by yunjie Xie on 15/11/27.
//  Copyright © 2015年 balintimes. All rights reserved.
//

import UIKit

class CityPickerViewController: UIViewController { 
    
    @IBOutlet weak var containerTopC: NSLayoutConstraint!
    @IBOutlet weak var containerView: UIView!

    var viewTopC:NSLayoutConstraint?;
    
    init(){
        
        let resourcesBundle = NSBundle(forClass:CityPickerViewController.self)
        super.init(nibName: "CityPickerViewController", bundle: resourcesBundle) 
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func show(parent:UIViewController){
        
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
 
        UIView.animateWithDuration(0.25, delay: 0.25, options: .CurveEaseInOut, animations: { () -> Void in
            
            self.containerTopC.constant = self.view.superview!.frame.height - self.containerView.frame.height;
            self.view.layoutIfNeeded()
            
            }, completion: nil);
        
    }
    func hide(){
        
        UIView.animateWithDuration(0.3, delay: 0.25, options: .CurveEaseInOut, animations: { () -> Void in
            
            self.containerTopC.constant = self.view.superview!.frame.height;
            self.containerView.layoutIfNeeded();
            }) { (bool) -> Void in
                
                self.viewTopC?.constant = self.view.superview!.frame.height;
        }
        
    }
    @IBAction func btnCancelClick(sender: AnyObject) {
        self.hide();
    }
    @IBAction func btnDoneClick(sender: AnyObject) {
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
