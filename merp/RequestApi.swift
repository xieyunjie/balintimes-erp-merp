//
//  RequestApi.swift
//  merp
//
//  Created by yunjie Xie on 15/11/18.
//  Copyright © 2015年 balintimes. All rights reserved.
//
import Alamofire
import UIKit
import ObjectMapper
import SwiftyJSON

class ResponseData<T:Mappable>{
    
    var data:String;
    
    var success:Bool;
    var msg:String;
    var isAuth:Bool?;
    var permission:Bool?;
    var total:Int;
    var pageSize:Int;
    
    init(data:String,success:Bool,msg:String,total:Int,pageSize:Int){
        self.data = data;
        self.success = success;
        self.msg = msg;
        self.total = total;
        self.pageSize = pageSize;
    }
    
    lazy var model:T? = {
        return  Mapper<T>().map(self.data);
        }();
    lazy var list:Array<T>? = {
        return Mapper<T>().mapArray(self.data);
        }();
}

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
                print(err?.code);
                
                failure(err);
        }
    }
    
    static func get<T:Mappable>(UrlString:String,_ parameters:[String:AnyObject]?,success:(ResponseData<T>)->Void,failure:(NSError?)->Void){
        
        requestData(.GET, UrlString, parameters, success: { (data) -> Void in
            
            let resJson = JSON(data:data);
            
            let retData = ResponseData<T>(data: resJson["data"].description, success: resJson["success"].boolValue, msg: resJson["message"].stringValue, total: resJson["total"].intValue, pageSize: resJson["pageSize"].intValue)
            
            success(retData);
            
            }) { (err) -> Void in
                print(err?.code);
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
                
                print(res.result.value);
                failure(res.result.error);
                
                return;
            }
            
            let json = String.init(data: res.data!, encoding: NSUTF8StringEncoding);
            
            success(json!);
            
        }
    }
    
    private static func requestData(method:Alamofire.Method,_ UrlString:URLStringConvertible,_ parameters:[String:AnyObject]?, success:(NSData)->Void,failure:(NSError?)->Void){
        
        Alamofire.request(method, UrlString, parameters: parameters, encoding: ParameterEncoding.JSON, headers: nil).responseJSON { ( res:Response<AnyObject, NSError>) -> Void in
            
            if res.result.isFailure == true{
                
                print(res.result.value);
                failure(res.result.error);
                
                return;
            }
            
            success(res.data!);
            
        }
    }
}