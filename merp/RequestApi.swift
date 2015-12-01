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
        if self.data.isEmpty == true {
            return nil;
        }
        return  Mapper<T>().map(self.data);
        }();
    lazy var list:Array<T>? = {
        if self.data.isEmpty == true {
            return nil;
        }
        return Mapper<T>().mapArray(self.data);
        }();
}

class UploadResponse:Mappable{
    
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        
    }
}

struct RequestApi{
    
    // post ==========
    static func post(UrlString:String,_ parameters:[String:AnyObject]?, success:(String)->Void,failure:((NSError?)->Void)?){
        
        request(.POST, UrlString, parameters, success: { (data) -> Void in
            success(data);
            }) { (err) -> Void in
                if let f = failure{
                    f(err);
                }
        }
        
    }
    static func post<T:Mappable>(UrlString:String,_ parameters:[String:AnyObject]?,success:(ResponseData<T>)->Void,failure:((NSError?)->Void)?){
        
        requestData(.POST, UrlString, parameters, success: { (data) -> Void in
            
            let resJson = JSON(data:data);
            
            let retData = ResponseData<T>(data: resJson["data"].description, success: resJson["success"].boolValue,
                                            msg: resJson["message"].stringValue, total: resJson["total"].intValue,
                                            pageSize: resJson["pageSize"].intValue)
            
            success(retData);
            
            }) { (err) -> Void in
                print(err?.code);
                if let f = failure{
                    f(err);
                }
        }
    }
    // post =============
    
    
    // get =============
    static func get(UrlString:String,_ parameters:[String:AnyObject]?, success:(String)->Void,failure:((NSError?)->Void)?){
        
        request(.GET, UrlString, parameters, success: { (data) -> Void in
            success(data);
            }) { (err) -> Void in
                print(err?.code);
                
                if let f = failure{
                    f(err);
                }
        }
    }
    
    static func get<T:Mappable>(UrlString:String,_ parameters:[String:AnyObject]?,success:(ResponseData<T>)->Void,failure:((NSError?)->Void)?){
        
        requestData(.GET, UrlString, parameters, success: { (data) -> Void in
            
            let resJson = JSON(data:data);
            
            let retData = ResponseData<T>(data: resJson["data"].description, success: resJson["success"].boolValue,
                                            msg: resJson["message"].stringValue, total: resJson["total"].intValue,
                                            pageSize: resJson["pageSize"].intValue)
            
            success(retData);
            
            }) { (err) -> Void in
                print(err?.code);
                if let f = failure{
                    f(err);
                }
        }
    }
    // get =============
    
    
    // put =============
    static func put(UrlString:String,_ parameters:[String:AnyObject]?, success:(String)->Void,failure:((NSError?)->Void)?){
        
        request(.PUT, UrlString, parameters, success: { (data) -> Void in
            success(data);
            }) { (err) -> Void in
                if let f = failure{
                    f(err);
                }
        }
        
    }
    static func put<T:Mappable>(UrlString:String,_ parameters:[String:AnyObject]?,success:(ResponseData<T>)->Void,failure:((NSError?)->Void)?){
        
        requestData(.PUT, UrlString, parameters, success: { (data) -> Void in
            
            let resJson = JSON(data:data);
            
            let retData = ResponseData<T>(data: resJson["data"].description, success: resJson["success"].boolValue,
                msg: resJson["message"].stringValue, total: resJson["total"].intValue,
                pageSize: resJson["pageSize"].intValue)
            
            success(retData);
            
            }) { (err) -> Void in
                print(err?.code);
                if let f = failure{
                    f(err);
                }
        }
    }
    // put ==============
    
    
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
    
    
    // upload
    static func upload(UrlString:URLStringConvertible, files:[String:UIImage],fields:[String:String]?,success:(ResponseData<UploadResponse>) -> Void,failure:((NSError?) -> Void)?){
        var filesDic = Dictionary<String,NSURL>();
        var fieldsDic = Dictionary<String,NSData>();
        
        var picData:NSData, fileFullPath:String?;
        for (key,image) in files{
            picData =  UIImageJPEGRepresentation(image, 0.8)!;
            fileFullPath = NSTemporaryDirectory().stringByAppendingString("\(key).png");
            picData.writeToFile(fileFullPath!, atomically: false);
            
            filesDic[key] = NSURL(fileURLWithPath: fileFullPath!);
        }
        
        if let fs = fields{
            for (key,value) in fs{
                
                fieldsDic[key] = value.dataUsingEncoding(NSUTF8StringEncoding);
            
            }
        }
        
        
        let  multipart = MultipartFormData();
        for (key,url) in filesDic{
            multipart.appendBodyPart(fileURL: url, name: key);
        }
        
        for (key,data) in fieldsDic{
            multipart.appendBodyPart(data: data, name: key);
        }
        
        
        Alamofire.upload(.POST, UrlString, headers: nil, multipartFormData: { (multipart) -> Void in
            
            for (key,url) in filesDic{
                multipart.appendBodyPart(fileURL: url, name: key);
            }
            
            for (key,data) in fieldsDic{
                multipart.appendBodyPart(data: data, name: key);
            }
            
            }, encodingMemoryThreshold:1024) { (encodingResult) -> Void in
                
                do{
                    for url in filesDic.values{
                        try NSFileManager.defaultManager().removeItemAtPath(url.path!);
                    }
                }
                catch {
                    
                }
                
                switch encodingResult{
                    case .Success(let upload,_,_):
                        upload.responseJSON(completionHandler: { (res) -> Void in
                            
                            if res.result.isFailure == true{
                                print(res.result.error?.code);
                                if let f = failure{
                                    f(res.result.error);
                                }
                                return;
                            }
                            
                            let resJson = JSON(data:res.data!);
                            
                            let retData = ResponseData<UploadResponse>(data: "", success: resJson["success"].boolValue,
                                msg: resJson["message"].stringValue, total: 0, pageSize: 0)
                            
                            success(retData);
                            
                            
                        });
                case .Failure(let err):
                    if let f = failure{
                        f(err as NSError);
                    }
                    
                }
        }

        
    
        
    }
    
}