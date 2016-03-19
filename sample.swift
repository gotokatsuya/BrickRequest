//
//  AppRequest.swift
//  Product
//
//  Created by Kazuki Yusa on 3/11/16.
//  Copyright © 2016 eure. All rights reserved.
//

import UIKit
import Alamofire
import BrickRequest
import SwiftyJSON
import PathKit

// Request Sample

class Request1: Component, GETRequestType, APISessionRequestType, SoftAutoRetryType, JSONResponseType {

    let userID: Int64
    let message: String

    var path: Path {
        return Path("/user/\(userID)")
    }

    init(userID: Int64, message: String) {
        self.userID = userID
        self.message = message

        var parameter = ParameterBuilder()
        parameter.add(TextParameter(value: message, name: "message"))

        super.init(parameterBuilder: parameter)
    }
}

// Define Bricks

enum AppRequestError: ErrorType {
    case UnknownError
}

protocol PathRequestType: RequestType {
    var path: Path { get }
}

extension PathRequestType {

    var URLString: String {
        return (SessionStack.baseURL + self.path).description
    }
}

protocol APISessionRequestType: RequestType {}

extension APISessionRequestType {

    var session: Session {
        return SessionStack.APIBackgroundSession
    }
}

protocol JSONResponseType: ResponseType {}

protocol GETRequestType: PathRequestType {}

extension GETRequestType {
    var method: Alamofire.Method {
        return .GET
    }
}

protocol DELETERequestType: PathRequestType {

}

extension DELETERequestType {
    var method: Alamofire.Method {
        return .DELETE
    }
}

protocol PUTRequestType: PathRequestType {}

extension PUTRequestType {
    var method: Alamofire.Method {
        return .PUT
    }
}

protocol POSTRequestType: PathRequestType {}

extension POSTRequestType {
    var method: Alamofire.Method {
        return .POST
    }
}

protocol HardAutoRetryType: RequestType {}

extension HardAutoRetryType {
    var autoRetryConfiguration: Component.AutoRetryConfiguration {
        return Component.AutoRetryConfiguration(maxRetryCount: 10)
    }
}

protocol SoftAutoRetryType: RequestType {}

extension SoftAutoRetryType {
    var autoRetryConfiguration: Component.AutoRetryConfiguration {
        return Component.AutoRetryConfiguration(maxRetryCount: 3)
    }
}

protocol NonAutoRetryType: RequestType {}

extension NonAutoRetryType {
    var autoRetryConfiguration: Component.AutoRetryConfiguration {
        return Component.AutoRetryConfiguration(maxRetryCount: 0)
    }
}

extension JSONResponseType {

    var responseSerializer: Alamofire.ResponseSerializer<JSON, AppRequestError> {
        return ResponseSerializer<JSON, AppRequestError> { request, response, data, error in

            guard let data = data where error == nil else {

                return .Failure(AppRequestError.UnknownError)
            }

            let json = JSON(data: data)
            guard json != JSON.null else {

                return .Failure(AppRequestError.UnknownError)
            }

            return .Success(json)
        }
    }
}
