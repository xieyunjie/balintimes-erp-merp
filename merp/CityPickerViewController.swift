//
//  CityPickerViewController.swift
//  merp
//
//  Created by yunjie Xie on 15/12/1.
//  Copyright © 2015年 balintimes. All rights reserved.
//

import UIKit
import MBProgressHUD

class CityPickerViewController: DataPickerViewController,UIPickerViewDelegate,UIPickerViewDataSource,DataPickerViewControllerDelegate{
    
    var provinces:Array<Province>?;
    var cities:Array<City>?;
    
    var done:((DataPickerViewController,Province,City) -> Void)!;
    var cancel:((DataPickerViewController) -> Void)!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func show(parent: UIViewController,_ sender:AnyObject, successAction:((DataPickerViewController,Province,City) -> Void)!,cancelAction:((DataPickerViewController) -> Void)?) {
        
        self.done = successAction;
        self.cancel = cancelAction;
        
        self.delegate = self;
        
        super.show(parent,sender:sender);
        
        self.navItem.title = "城市选择";
        
    }
    func pickerShowCompletion(finish:Bool){
        
        guard finish == true else{
            return;
        }
        
        guard self.provinces == nil else{
            return;
        }
        
        self.dataPicker.dataSource = self;
        self.dataPicker.delegate = self;
        
        
        MBProgressHUD.showHUDAddedTo(self.view, animated: true);
        
        RequestApi.get("http://172.16.0.194:3000/crm/province", nil, success: { (ret:ResponseData<Province>) -> Void in
            self.provinces = ret.list;
            MBProgressHUD.hideHUDForView(self.view, animated: true);
            self.dataPicker.reloadComponent(0)
            self.dataPicker.selectRow(0, inComponent: 0, animated: true)
            
            self.pickerView(self.dataPicker, didSelectRow: 0, inComponent: 0);
            
            }) { (err) -> Void in
                
        }
    }
    func pickerDone() {
        if let d = self.done {
            let province = self.provinces![self.dataPicker.selectedRowInComponent(0)];
            let city = self.cities![self.dataPicker.selectedRowInComponent(1)];
            
            d(self,province,city);
        }
    }
    
    func pickerCancel() {
        if let c = self.cancel{
            c(self);
        }
    }
    
    
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        return 2;
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        if component == 0 {
            return provinces == nil ? 0 : (provinces?.count)!;
        }
        else if component == 1 {
            return cities == nil ? 0 : (cities?.count)!;
        }
        return 0;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0 && provinces != nil {
            return provinces?[row].name;
        }
        else if component == 1 && cities != nil{
            return cities?[row].name
        }
        
        return "error";
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("didSelectRow");
        if component == 0{
            let province = self.provinces?[row];
            
            if let p = province{
                MBProgressHUD.showHUDAddedTo(self.view, animated: true);
                RequestApi.get("http://172.16.0.194:3000/crm/cities/\(p.id!)", nil, success: { (ret:ResponseData<City>) -> Void in
                    
                    self.cities = ret.list;
                    self.dataPicker.reloadComponent(1);
                    MBProgressHUD.hideHUDForView(self.view, animated: true);
                    self.dataPicker.selectRow(0, inComponent: 1, animated: true);
                    
                    }) { (err) -> Void in
                        
                }
            }
            else{
                print(self.provinces);
            }
        }
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
