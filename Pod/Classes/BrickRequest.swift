//
//  File.swift
//  Pods
//
//  Created by muukii on 3/24/16.
//
//

import Foundation
import Alamofire

public protocol RequestContextType {
    
}

extension RequestContextType where Self: ResponseType, Self: RequestType {
    
    public func create(block: Alamofire.Response<SerializedObject, ResponseError> -> Void) -> Alamofire.Request {
        
        let request = self.createRequest(method: self.method, URLString: self.URLString, manager: self.manager)
        request.response(responseSerializer: self.responseSerializer, completionHandler: block)
        return request
    }
}

public protocol RequestType {
    
    var method: Alamofire.Method { get }
    var URLString: String { get }
    var manager: Alamofire.Manager { get }
    func createRequest(method method: Alamofire.Method, URLString: String, manager: Alamofire.Manager) -> Alamofire.Request
}

public protocol ResponseType {
    
    associatedtype SerializedObject
    associatedtype ResponseError: ErrorType
    
    var responseSerializer: Alamofire.ResponseSerializer<SerializedObject, ResponseError> { get }
}
