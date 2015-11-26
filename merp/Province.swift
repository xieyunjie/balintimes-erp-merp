//
//  Province.swift
//  BLActionPickerView
//
//  Created by yunjie Xie on 15/11/25.
//  Copyright © 2015年 balintimes. All rights reserved.
//

import Foundation
import ObjectMapper

class Province:NSObject,Mappable{
    var id:String?;
    var name:String?
    var createtime:NSDate?
    
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        
        id <- map["id"];
        name <- map["name"];
        createtime <- map["createtime"];

    }
}
