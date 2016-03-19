//  HttpbinTests.swift
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
import Quick
import Nimble
@testable import BrickRequest

class HTTPbinTest: QuickSpec {
    
    override func spec() {
        describe("Request: GET") {
            it("") {
                waitUntil(timeout: 20) { done in
                    let request = GetHttpbin(text: "string", number: 45)
                    request.response { response in
                        switch response.result {
                        case .Success(let value):
                            print(value)
                            let json = value["args"]
                            expect(json["text"].string).to(equal("string"))
                            expect(json["number"].string).to(equal("45"))
                        case .Failure(let error):
                            fail("\(error)")
                        }
                        done()
                    }
                    request.resume()
                }
            }
        }
        
        describe("Request: DELETE") {
            it("") {
                waitUntil(timeout: 20) { done in
                    
                    let request = DeleteHttpbin(text: "string", number: 45)
                    request.response { response in
                        switch response.result {
                        case .Success(let value):
                            
                            let json = value["args"]
                            expect(json["text"].string).to(equal("string"))
                            expect(json["number"].string).to(equal("45"))
                        case .Failure(let error):
                            fail("\(error)")
                        }
                        done()
                    }
                    request.resume()
                }
            }
        }
        
        describe("Request: POST") {
            it("") {
                waitUntil(timeout: 20) { done in
                    
                    let image = UIImage(named: "icon.png", inBundle: NSBundle(forClass: self.dynamicType), compatibleWithTraitCollection: nil)
                    let data = UIImagePNGRepresentation(image!)
                    
                    let request = PostHttpbin(text: "string", number: 45, data: data)
                    request.response { response in
                        switch response.result {
                        case .Success(let value):
                            
                            print(value)
//                            let json = value["args"]
//                            expect(json["text"].string).to(equal("string"))
//                            expect(json["number"].string).to(equal("45"))
                            
                        case .Failure(let error):
                            fail("\(error)")
                        }
                        done()
                    }
                    request.resume()
                }
            }
        }
        
        describe("Request: PUT") {
            it("") {
                waitUntil(timeout: 20) { done in
                    
                    let image = UIImage(named: "icon.png", inBundle: NSBundle(forClass: self.dynamicType), compatibleWithTraitCollection: nil)
                    let data = UIImagePNGRepresentation(image!)
                    
                    let request = PutHttpbin(text: "string", number: 45, data: data)
                    request.response { response in
                        switch response.result {
                        case .Success(let value):
                            
                            let json = value["args"]
//                            expect(json["text"].string).to(equal("string"))
//                            expect(json["number"].string).to(equal("45"))
                            
                        case .Failure(let error):
                            fail("\(error)")
                        }
                        done()
                    }
                    request.resume()
                }
            }
        }
    }
}
