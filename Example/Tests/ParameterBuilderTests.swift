// ParameterBuilder.swift
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
@testable import EasyRequest


class ParameterBuilder: QuickSpec {
    
    override func spec() {
        describe("Check convert value for HTTP Reqest") {
            context("String") {
                it("is non nil") {
                    
                    expect(TextParameter(value: "abc", name: "keyName").string).to(equal("abc"))
                }
                
                it("is nil") {
                    
                    expect(TextParameter(value: Optional<String>(), name: "keyName").string).to(beNil())
                }
                
                it("is nil catching") {
                    
                    expect( TextParameter(value: Optional<String>(), name: "keyName")
                        .catchOnNil{ () -> String in
                            return "cdf"
                        }.string).to(equal("cdf"))
                }
            }
            
            context("Int") {
                it("is non nil") {
                    
                    expect(TextParameter(value: Int(100), name: "keyName").string).to(equal("100"))
                }
                
                it("is nil") {
                    
                    expect(TextParameter(value: Optional<Int>(), name: "keyName").string).to(beNil())
                }
                
                it("is nil catching") {
                    
                    expect(TextParameter(value: Optional<Int>(), name: "keyName")
                        .catchOnNil{ () -> Int in
                            return Int(100)
                        }.string).to(equal("100"))
                }
            }
            
            context("Bool") {
                it("is non nil") {
                    
                    expect(TextParameter(value: true, name: "keyName").string).to(equal("1"))
                }
                
                it("is nil") {
                    
                    expect(TextParameter(value: Optional<Bool>(), name: "keyName").string).to(beNil())
                }
                
                it("is nil catching") {
                    
                    expect(TextParameter(value: Optional<Bool>(), name: "keyName")
                        .catchOnNil{ () -> Bool in
                            return true
                        }.string).to(equal("1"))
                }
            }
        }
    }
}
