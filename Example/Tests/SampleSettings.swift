//
//  DefaultSettings.swift
//  Pods
//
//  Created by muukii on 3/24/16.
//
//

import Foundation
import Alamofire

protocol SharedManagerRequestType: RequestType {}
extension SharedManagerRequestType {
    var manager: Manager {
        return Alamofire.Manager.sharedInstance
    }
}

protocol GETRequestType: SharedManagerRequestType {}
extension GETRequestType {
    var method: Alamofire.Method {
        return .GET
    }
}

protocol DELETERequestType: SharedManagerRequestType {}
extension DELETERequestType {
    var method: Alamofire.Method {
        return .DELETE
    }
}


protocol PUTRequestType: SharedManagerRequestType {}
extension PUTRequestType {
    var method: Alamofire.Method {
        return .PUT
    }
}


protocol POSTRequestType: SharedManagerRequestType {}
extension POSTRequestType {
    var method: Alamofire.Method {
        return .POST
    }
}

protocol HTTPBinRequestType: RequestType {
    var path: String { get }
}
extension HTTPBinRequestType {
    var URLString: String {
        return "https://httpbin.org/" + self.path
    }
}
