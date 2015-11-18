//
//  RequestApi.swift
//  merp
//
//  Created by yunjie Xie on 15/11/18.
//  Copyright © 2015年 balintimes. All rights reserved.
//

import Alamofire
import ObjectMapper

struct RequestApi{
    
    static func post(UrlString:String,_ parameters:[String:AnyObject]?, success:(String)->Void,failure:(NSError?)->Void){

        request(.POST, UrlString, parameters, success: { (data) -> Void in
            success(data);
            }) { (err) -> Void in
                failure(err);
        }
 
    }
    
    static func get(UrlString:String,_ parameters:[String:AnyObject]?, success:(String)->Void,failure:(NSError?)->Void){
        
        request(.GET, UrlString, parameters, success: { (data) -> Void in
            success(data);
            }) { (err) -> Void in
                failure(err);
        }
        
    }
    
    static func put(UrlString:String,_ parameters:[String:AnyObject]?, success:(String)->Void,failure:(NSError?)->Void){
        
        request(.PUT, UrlString, parameters, success: { (data) -> Void in
            success(data);
            }) { (err) -> Void in
                failure(err);
        }
        
    }
    
    
    private static func request(method:Alamofire.Method,_ UrlString:URLStringConvertible,_ parameters:[String:AnyObject]?, success:(String)->Void,failure:(NSError?)->Void){
        
        Alamofire.request(method, UrlString, parameters: parameters, encoding: ParameterEncoding.JSON, headers: nil).responseJSON { ( res:Response<AnyObject, NSError>) -> Void in
            
            if res.result.isFailure == true{
                
                failure(res.result.error);
                
                return;
            }
            
             let json = String.init(data: res.data!, encoding: NSUTF8StringEncoding);
            
            success(json!);
            
            
        }
        
    }
    
}