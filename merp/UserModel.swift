//
//  CommonViewModel.swift
//  merp
//
//  Created by yunjie Xie on 15/11/19.
//  Copyright © 2015年 balintimes. All rights reserved.
//

import Foundation


class UserModel: NSObject {
    
    var icon:String = "";
    var label:String = "";
    var board:String = "";
    var controller:String = "";
    
//    init(icon:String,label:String,board:String,controller:String){
//        
//        self.icon = icon;
//        self.label = label;
//        self.board = board;
//        self.controller = controller;
//    }
    
    
    class func createModel(dic:[String:AnyObject]) -> UserModel{
        
        let model = UserModel();
        model.setValuesForKeysWithDictionary(dic);
        
        return model;
        
    }
}