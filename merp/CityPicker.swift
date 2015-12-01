//
//  CityPicker.swift
//  BLActionPickerView
//
//  Created by yunjie Xie on 15/11/25.
//  Copyright © 2015年 balintimes. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper
import MBProgressHUD

class CityPicker:BaseActionSheetPickerView {
    
    var provinces:Array<Province>?;
    var cities:Array<City>?;
    var selectedFn:((BaseActionSheetPickerView,Province,City)->Void)?;
    
    class func create(controller controller:UIViewController, successAction:((BaseActionSheetPickerView,Province,City)->Void)!,cancelAction:((BaseActionSheetPickerView)->Void)!,origin:AnyObject!) -> CityPicker{
        
        ////        let picker = CityPicker(origin: origin, doneTitle: "完成", cancelTitle: "取消", pickerTitle: "无");
        //        let picker = CityPicker(title: "s", origin: origin);
        
        let picker = CityPicker(target: nil, successAction: nil, cancelAction: nil, origin: origin);
        picker.setDefaultBottons();
        
        picker.selectedFn = successAction;
        picker.cancelFn = cancelAction;
        picker.parentController = controller;
        
        return picker;
    }
    
    override func showActionSheetPicker() {
        
        MBProgressHUD.showHUDAddedTo(self.parentController?.view, animated: true);
        
        RequestApi.get("http://172.16.0.194:3000/crm/province", nil, success: { (ret:ResponseData<Province>) -> Void in
            self.provinces = ret.list;
            super.showActionSheetPicker();
            MBProgressHUD.hideHUDForView(self.parentController?.view, animated: true);
            self.basePickerView.reloadComponent(0);
            self.basePickerView.selectRow(0, inComponent: 0, animated: true)
            
            self.pickerView(self.basePickerView, didSelectRow: 0, inComponent: 0);
            
            }) { (err) -> Void in
                
        }
        //        RequestApi.get("http://172.16.0.194:3000/crm/province", nil, success: { (json) -> Void in
        //
        //            self.provinces = Mapper<Province>().mapArray(json);
        //            //            let picker = self.pickerView as! UIPickerView;
        //            //
        //            super.showActionSheetPicker();
        //            MBProgressHUD.hideHUDForView(self.parentController?.view, animated: true);
        //            self.basePickerView.reloadComponent(0);
        //            self.basePickerView.selectRow(0, inComponent: 0, animated: true)
        //
        //            self.pickerView(self.basePickerView, didSelectRow: 0, inComponent: 0);
        //
        //            }) { (err) -> Void in
        //                MBProgressHUD.hideHUDForView(self.parentController?.view, animated: true);
        //
        //        };
    }
    
    override func notifyTarget(target: AnyObject!, didSucceedWithAction successAction: Selector, origin: AnyObject!) {
        
        self.selectedFn!(self,self.provinces![self.basePickerView.selectedRowInComponent(0)],self.cities![self.basePickerView.selectedRowInComponent(1)]);
    }
    
    
    override func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        return 2;
    }
    
    override func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
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
                
                MBProgressHUD.showHUDAddedTo(self.pickerView, animated: true);
                RequestApi.get("http://172.16.0.194:3000/crm/cities/\(p.id!)", nil, success: { (ret:ResponseData<City>) -> Void in
                    self.cities = ret.list;
                    self.basePickerView.reloadComponent(1);
                    MBProgressHUD.hideHUDForView(self.pickerView, animated: true);
                    
                    }) { (err) -> Void in
                        
                }
            }
            else{
                print(self.provinces);
            }
        }
    }
    
}