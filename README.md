# BrickRequest
[![CI Status](http://img.shields.io/travis/muukii/BrickRequest.svg?style=flat)](https://travis-ci.org/muukii/BrickRequest) [![Version](https://img.shields.io/cocoapods/v/BrickRequest.svg?style=flat)](http://cocoapods.org/pods/BrickRequest) [![License](https://img.shields.io/cocoapods/l/BrickRequest.svg?style=flat)](http://cocoapods.org/pods/BrickRequest) [![Platform](https://img.shields.io/cocoapods/p/BrickRequest.svg?style=flat)](http://cocoapods.org/pods/BrickRequest)
<center>
<img src="icon.png">
</center>


**Abstruct Framewrok of Request**

## Requirements
iOS8.0 +, Swift2.2

## Whats is *Brick*?

BrickRequest provides protocol only.

You need implement this protocols.
Then API request will be clean.

- RequestContextType
- RequestType
- ResponseType

```
let request = RequestContextType.create { response in
    // Response process
}

request.resume()
```

```
public protocol RequestContextType {

}

extension RequestContextType where Self: ResponseType, Self: RequestType {

    public func create(block: Alamofire.Response<SerializedObject, ResponseError> -> Void) -> Alamofire.Request {

        let request = self.createRequest(method: self.method, URLString: self.URLString, manager: self.manager)
        request.response(responseSerializer: self.responseSerializer, completionHandler: block)
        return request
    }
}

public protocol RequestType {

    var method: Alamofire.Method { get }
    var URLString: String { get }
    var manager: Alamofire.Manager { get }
    func createRequest(method method: Alamofire.Method, URLString: String, manager: Alamofire.Manager) -> Alamofire.Request
}

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
