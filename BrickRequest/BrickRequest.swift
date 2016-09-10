// BrickRequest.swift
//
// Copyright (c) 2015 muukii
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation
import Alamofire

public protocol RequestContextType {

}

extension RequestContextType where Self: ResponseType, Self: RequestType {

    public func create(_ block: @escaping (Alamofire.DataResponse<Self.SerializedObject>) -> Void) -> Alamofire.Request {
        
        manager.startRequestsImmediately = false
        let request = createRequest(method: method, URLString: URLString, manager: manager)
        request.response(responseSerializer: responseSerializer, completionHandler: block)
        
        return request
    }
}

public protocol RequestType {

    var method: Alamofire.Method { get }
    var URLString: String { get }
    var manager: Alamofire.SessionManager { get }
    func createRequest(method: Alamofire.Method, URLString: String, manager: Alamofire.SessionManager) -> Alamofire.DataRequest
}

public protocol ResponseType {

    associatedtype SerializedObject
    
    var responseSerializer: Alamofire.DataResponseSerializer<SerializedObject> { get }
}
