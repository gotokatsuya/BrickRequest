// ResponseType.swift
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

public protocol ResponseType {
    
    typealias SerializedObject
    typealias ResponseError: ErrorType
    
    var responseSerializer: Alamofire.ResponseSerializer<SerializedObject, ResponseError> { get }
}

extension ResponseType where Self: Component, Self: RequestType {
    
    public func response(responseBlock: Alamofire.Response<SerializedObject, ResponseError> -> Void) {
        
        let request = self.createRequest(self)
        request.response(responseSerializer: self.responseSerializer) { (response) -> Void in
            switch response.result {
            case .Success:
                responseBlock(response)
            case .Failure:
                
                if self.retryCount <= self.autoRetryConfiguration.maxRetryCount {
                    
                    let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(self.autoRetryConfiguration.breakTime * Double(NSEC_PER_SEC)))
                    dispatch_after(delayTime, dispatch_get_main_queue()) {
                        self.increseRetryCount()
                        self.response(responseBlock)
                        self.resume()
                    }
                } else {
                    responseBlock(response)
                }
            }
        }
        self.request = request
    }    
}
