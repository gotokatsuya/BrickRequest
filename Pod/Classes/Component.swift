// Component.swift
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

import UIKit
import Alamofire

public func == (lhs: Component, rhs: Component) -> Bool {
    
    return lhs === rhs
}

public class Component: Hashable {
    
    public struct AutoRetryConfiguration {
        
        public var breakTime: NSTimeInterval
        public var maxRetryCount: Int
        public var enableBackgroundRetry: Bool
        public var failWhenNotReachable: Bool
        
        public init(breakTime: NSTimeInterval = 5,
                    maxRetryCount: Int = 5,
                    enableBackgroundRetry: Bool = true,
                    failWhenNotReachable: Bool = false) {
            
            self.breakTime = breakTime
            self.maxRetryCount = maxRetryCount
            self.enableBackgroundRetry = enableBackgroundRetry
            self.failWhenNotReachable = failWhenNotReachable
        }
    }
    
    public let parameterBuilder: ParameterBuilder
    
    public internal(set) var retryCount: Int = 0
    public internal(set) var request: Alamofire.Request?
    
    public var status: NSURLSessionTaskState? {
        return self.request?.task.state
    }
    
    public init(parameterBuilder: ParameterBuilder) {
        self.parameterBuilder = parameterBuilder
    }
    
    internal func increseRetryCount() {
        
        self.retryCount = self.retryCount + 1
    }        
    
    // MARK: - Hashable
    public var hashValue: Int {
        return ObjectIdentifier(self).hashValue
    }
}
