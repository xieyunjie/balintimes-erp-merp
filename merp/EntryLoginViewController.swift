//
//  EntryLoginViewController.swift
//  merp
//
//  Created by yunjie Xie on 15/11/18.
//  Copyright © 2015年 balintimes. All rights reserved.
//

import UIKit

class EntryLoginViewController: UIViewController {
    
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!

    @IBAction func btnLoginClick(sender: AnyObject) {
        
        self.resignFirstResponder();
        
        if txtUserName.text != nil && self.txtPassword.text != nil{
            
            let username = self.txtUserName.text!;
            let password = self.txtPassword.text!;
            
            if username == password{
                
                self.performSegueWithIdentifier("entryErpList", sender: self);
            }
            else{
                let alertV = DlgMsg.alert("提示", "登录失败 用户名或密码录入有误", handler: { (action) -> Void in
                    self.txtUserName.becomeFirstResponder();
                })
                
                self .presentViewController(alertV, animated: true, completion: { () -> Void in
//                    self.txtUserName.becomeFirstResponder();
                    print("completion");
                })
            }
            
        }else{
            let alertV = DlgMsg.alert("提示", "用户名或密码录入有误",handler:nil);
            self .presentViewController(alertV, animated: true, completion: { () -> Void in
//                self.txtUserName.becomeFirstResponder();
                
            })
        }
        
    }
    @IBAction func btnResetClick(sender: AnyObject) {
        
        self.txtPassword.text = "";
        self.txtUserName.text = "";
        
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
