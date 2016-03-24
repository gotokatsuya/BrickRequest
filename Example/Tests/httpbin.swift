// httpbin.swift 
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
import SwiftyJSON

@testable import BrickRequest

protocol SharedSessionRequestType: RequestType {}
protocol JSONResponseType: ResponseType {}

let baseURLString = "https://httpbin.org/"

enum TestError: ErrorType {
    case Error
}

extension JSONResponseType {
    
    var responseSerializer: Alamofire.ResponseSerializer<JSON, TestError> {
        return ResponseSerializer<JSON, TestError> { request, response, data, error in
            
            guard let data = data where error == nil else {
                
                return .Failure(TestError.Error)
            }
            
            let json = JSON(data: data)
            guard json != JSON.null else {
                
                return .Failure(TestError.Error)
            }
            
            return .Success(json)
        }
    }
}

extension SharedSessionRequestType {
    var session: Session {
        
        return Session.sharedSession
    }
}

protocol GetRequestType: RequestType {
    
}

extension GetRequestType {
    var method: Alamofire.Method {
        return .GET
    }
    
    var autoRetryConfiguration: Component.AutoRetryConfiguration {
        return Component.AutoRetryConfiguration(maxRetryCount: 3)
    }
}

protocol DeleteRequestType: RequestType {
    
}

extension DeleteRequestType {
    var method: Alamofire.Method {
        return .DELETE
    }
    
    var autoRetryConfiguration: Component.AutoRetryConfiguration {
        return Component.AutoRetryConfiguration(maxRetryCount: 3)
    }
}

protocol PutRequestType: RequestType {
    
}

extension PutRequestType {
    var method: Alamofire.Method {
        return .PUT
    }
    
    var autoRetryConfiguration: Component.AutoRetryConfiguration {
        return Component.AutoRetryConfiguration(maxRetryCount: 3)
    }
}

protocol PostRequestType: RequestType {
    
}

extension PostRequestType {
    var method: Alamofire.Method {
        return .POST
    }
    
    var autoRetryConfiguration: Component.AutoRetryConfiguration {
        return Component.AutoRetryConfiguration(maxRetryCount: 3)
    }
}


final class GetHttpbin: Component, SharedSessionRequestType, GetRequestType, JSONResponseType {
    
    required init(text: String, number: Int) {
        var param = ParameterBuilder()
        param.add(TextParameter(value: text, name: "text"))
        param.add(TextParameter(value: number, name: "number"))
        
        super.init(parameterBuilder: param)
    }
    
    var URLString: String {
        return baseURLString + "/get"
    }
}

final class DeleteHttpbin: Component, SharedSessionRequestType, DeleteRequestType, JSONResponseType {
    
    required init(text: String, number: Int) {
        var param = ParameterBuilder()
        param.add(TextParameter(value: text, name: "text"))
        param.add(TextParameter(value: number, name: "number"))
        
        super.init(parameterBuilder: param)
    }
    
    var URLString: String {
        return baseURLString + "/delete"
    }
}

final class PostHttpbin: Component, SharedSessionRequestType, PostRequestType, JSONResponseType {
    
    required init(text: String?, number: Int?, data: NSData?) {
        var param = ParameterBuilder()
        param.add(TextParameter(value: text, name: "text"))
        param.add(TextParameter(value: number, name: "number"))
        param.add(FileParameter(data, name: "", fileName: "", mimeType: ""))
        
        super.init(parameterBuilder: param)
    }
    
    var URLString: String {
        return baseURLString + "/post"
    }
}

final class PutHttpbin: Component, SharedSessionRequestType, PutRequestType, JSONResponseType {
    
    required init(text: String?, number: Int?, data: NSData?) {
        var param = ParameterBuilder()
        param.add(TextParameter(value: text, name: "text"))
        param.add(TextParameter(value: number, name: "number"))
        param.add(FileParameter(data, name: "", fileName: "", mimeType: ""))
        
        super.init(parameterBuilder: param)
    }
    
    var URLString: String {
        return baseURLString + "/put"
    }
}
