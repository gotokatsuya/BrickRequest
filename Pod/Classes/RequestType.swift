// RequestType.swift
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

public protocol RequestType {
    
    var method: Alamofire.Method { get }
    var URLString: String { get }
    
    var session: Session { get }
    var autoRetryConfiguration: Component.AutoRetryConfiguration { get }
}

extension RequestType where Self: Component, Self: ResponseType {
    
    public func resume() {
        self.session.dispatch(self)
    }
    
    public func cancel() {
        self.session.dispatchCancel(self)
    }
    
    func createRequest(component: Component) -> Alamofire.Request {
        
        // TODO: Background save to disk.
        switch self.method {
        case .GET, .DELETE:
            
            let params = component.parameterBuilder.createParameter()
            return self.session.manager.request(self.method, self.URLString, parameters: params)                    
    
        case .PUT, .POST:
            
            try! NSFileManager.defaultManager().createDirectoryAtPath(self.session.saveBodyPath, withIntermediateDirectories: true, attributes: nil)
            let bodyDataFileURL = NSURL(fileURLWithPath: self.session.saveBodyPath + NSUUID().UUIDString)
            try! self.parameterBuilder.createMultipartFormData().writeEncodedDataToDisk(bodyDataFileURL)
            return self.session.manager.upload(self.method, self.URLString, file: bodyDataFileURL)
        default:
            preconditionFailure("Does not supported")
        }
    }
}
