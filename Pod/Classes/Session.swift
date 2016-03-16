// Session.swift
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

public class Session {
    
    public static let sharedSession = Session(manager: Alamofire.Manager.sharedInstance, reachablityManager: NetworkReachabilityManager())

    public var saveBodyPath = NSTemporaryDirectory() + "BackgroundTasks/"
    public private(set) var runningRequests = Set<Component>()

    public let reachablityManager: NetworkReachabilityManager?
    public let manager: Alamofire.Manager
    
    public init(manager: Alamofire.Manager, reachablityManager: NetworkReachabilityManager?) {
        
        self.manager = manager
        self.reachablityManager = reachablityManager

        self.reachablityManager?.listener = { [weak self] status in
            
            guard let _ = self?.reachablityManager?.isReachable else {
                
                return
            }
            self?.runningRequests.forEach { [weak self] component in
                
                self?.dispatch(component)
            }
        }
        self.reachablityManager?.startListening()
    }
    
    deinit {
        
        self.reachablityManager?.stopListening()
    }
    
    func dispatch(component: Component) {
        
        self.runningRequests.insert(component)
        
        if self.reachablityManager?.isReachable == true {
            if let component = self.runningRequests.first {
                
                component.request?.response(completionHandler: { (request, response, data, error) -> Void in
                    self.runningRequests.remove(component)
                })
                component.request?.resume()
            }
        }
    }
    
    func dispatchCancel<T where T: Component, T: RequestType, T: ResponseType>(component: T) {
        
        component.request?.cancel()
    }
    
}
