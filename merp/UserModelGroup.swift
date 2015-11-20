//
//  UserModelGroup.swift
//  merp
//
//  Created by yunjie Xie on 15/11/19.
//  Copyright © 2015年 balintimes. All rights reserved.
//

import Foundation

class UserModelGroup:NSObject{
    
    var name:String?;
    var icon:String?;
    
    var visible:Bool = false;
    
    var models:[UserModel]?;
    
    
    class func createGroup(dic:[String:AnyObject]) -> UserModelGroup{
        
        let group = UserModelGroup();
        
        group.setValuesForKeysWithDictionary(dic);
        
        let aryDic = dic["models"] as! NSArray;
        
        group.models = Array<UserModel>();
        
        for modelDic in aryDic{
            let model = UserModel();
            model.setValuesForKeysWithDictionary(modelDic as! [String:AnyObject]);
            
            group.models?.append(model);
            
        }
        
        return group;
    }
}