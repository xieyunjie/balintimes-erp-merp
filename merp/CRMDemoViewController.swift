//
//  CRMDemoViewController.swift
//  merp
//
//  Created by yunjie Xie on 15/11/26.
//  Copyright © 2015年 balintimes. All rights reserved.
//

import UIKit

class CRMDemoViewController: UIViewController {

    @IBOutlet weak var txtCity: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtCity.inputView = UIView(frame: CGRectZero);

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func txtCityTouchDown(sender: AnyObject) {
        
        let cityPicker = CityPicker.create(controller: self, successAction: self.txtCityDone, cancelAction: self.txtCityCancel, origin: sender);
        
        cityPicker.showActionSheetPicker();
    }
    
    func txtCityDone(sender:BaseActionSheetPickerView,province:Province,city:City){
        txtCity.text = "\(province.name!) -> \(city.name!)";
    }
    func txtCityCancel(sender:BaseActionSheetPickerView){
        print("cancel");
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
