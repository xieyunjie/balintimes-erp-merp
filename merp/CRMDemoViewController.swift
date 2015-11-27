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
    
    @IBOutlet weak var txtDate: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtCity.inputView = UIView(frame: CGRectZero);
        txtDate.inputView = UIView(frame: CGRectZero);

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
    
    var datePickerCtrl = DatePickerViewController();
    @IBAction func btnDatePickerClick(sender: AnyObject) {
        
        datePickerCtrl.show(self);
    }
    @IBAction func txtDateClick(sender: AnyObject) {
        datePickerCtrl.show(self, doneAction: self.txtDateDone,cancelAction: self.txtDateCancel);
    }
    
    func txtDateDone(sender:DatePickerViewController,date:NSDate){
        
        let format = NSDateFormatter();
//        format.dateFromString("yyyy-MM-dd");
        format.dateFormat = "yyyy-MM-dd";
        self.txtDate.text = format.stringFromDate(date);
    }
    func txtDateCancel(sender:DatePickerViewController){
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
