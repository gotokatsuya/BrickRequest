# BrickRequest
[![CI Status](http://img.shields.io/travis/muukii/BrickRequest.svg?style=flat)](https://travis-ci.org/muukii/BrickRequest) [![Version](https://img.shields.io/cocoapods/v/BrickRequest.svg?style=flat)](http://cocoapods.org/pods/BrickRequest) [![License](https://img.shields.io/cocoapods/l/BrickRequest.svg?style=flat)](http://cocoapods.org/pods/BrickRequest) [![Platform](https://img.shields.io/cocoapods/p/BrickRequest.svg?style=flat)](http://cocoapods.org/pods/BrickRequest)
<center>
<img src="icon.png">
</center>

- This is still in development, so there may be lacking functionality, and API may change.
- BrickRequest is a helper library for Alamofire.
- You can improve readability and DRYness when working with Alamofire.
- BrickRequest provides several protocols.
- By using protocol extensions, you can build requests, just like building with LEGO bricks.
- You can understand what the request does just by seeing the class signature.
- Auto-retry ability is provided using `Reachability`

## Requirements
iOS8.0 +, Swift2.2

## Usage example
For example, a request that retrieves an User is built like this:

```swift
class GetUser: Component, GETRequestType, APISessionRequestType, SoftAutoRetryType, JSONResponseType {

    let userID: String

    var URLString: String {
        return "https://httpbin.org/get"
    }

    init(userID: String) {
        self.userID = userID        

        var parameter = ParameterBuilder()
        parameter.add(TextParameter(value: userID, name: "userID"))

        super.init(parameterBuilder: parameter)
    }
}
```

Dispatch...

```swift

let request = GetUser(userID: 100)

request.response { response in
    switch response.result {
      case .Success(let json):
          break
      case .Failure(let error):
          break
    }  
}

request.resume()
```

## Sample Protocols

`GetUser` conform to many protocols. Each of them are like Bricks, and you implement them like this:

Define a Brick that will set the request type as `GET`.

```swift
protocol GETRequestType: RequestType {}

extension GETRequestType {

    var method: Alamofire.Method {

        return .GET
    }
}
```

Define a Brick that will set the `Session` to be used in a request.

```swift
protocol APISessionRequestType: RequestType {}

extension APISessionRequestType {

    var session: Session {

        return SessionStack.APIBackgroundSession
    }
}
```

Define a Brick that will configure auto-retry to be run up to 3 times.

```swift
protocol SoftAutoRetryType: RequestType {}

extension SoftAutoRetryType {

    var autoRetryConfiguration: Component.AutoRetryConfiguration {

        return Component.AutoRetryConfiguration(maxRetryCount: 3)
    }
}
```

Define a Brick that will convert responses to SwityJSON JSON objects.

```swift
extension JSONResponseType {

    var responseSerializer: Alamofire.ResponseSerializer<JSON, AppRequestError> {

        return ResponseSerializer<SwiftyJSON.JSON, AppRequestError> { request, response, data, error in

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
```

## Architecture

- `Session` manages requests.

```swift
public class Session {

    public init(manager: Alamofire.Manager, reachablityManager: Alamofire.NetworkReachabilityManager?)
```

- `Component` is used for creating requests (maybe renamed to RequestContext).

```swift
public class Component: Hashable {

    public let parameterBuilder: ParameterBuilder

    public init(parameterBuilder: ParameterBuilder) {
        self.parameterBuilder = parameterBuilder
    }
}
```

```swift
public struct Component.AutoRetryConfiguration {

    public var breakTime: NSTimeInterval
    public var maxRetryCount: Int
    // TODO: public var enableBackgroundRetry: Bool
    // TODO: public var failWhenNotReachable: Bool

    public init(breakTime: NSTimeInterval = 5,
                maxRetryCount: Int = 5,
                enableBackgroundRetry: Bool = true,
                failWhenNotReachable: Bool = false) {

        self.breakTime = breakTime
        self.maxRetryCount = maxRetryCount
    }
}
```

To send a request, you need to extend `Component` and conform to the following 2 protocols.

```swift
public protocol RequestType {

    var method: Alamofire.Method { get }
    var URLString: String { get }

    var session: Session { get }
    var autoRetryConfiguration: Component.AutoRetryConfiguration { get }
}
```

```swift
public protocol ResponseType {

    associatedtype SerializedObject
    associatedtype ResponseError: ErrorType

    var responseSerializer: Alamofire.ResponseSerializer<SerializedObject, ResponseError> { get }
}
```

## Installation
BrickRequest is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod "BrickRequest"
```

## Author
muukii, m@muukii.me

## License
BrickRequest is available under the MIT license. See the LICENSE file for more info.
