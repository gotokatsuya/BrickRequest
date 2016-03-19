# BrickRequest

[![CI Status](http://img.shields.io/travis/muukii/BrickRequest.svg?style=flat)](https://travis-ci.org/muukii/BrickRequest)
[![Version](https://img.shields.io/cocoapods/v/BrickRequest.svg?style=flat)](http://cocoapods.org/pods/BrickRequest)
[![License](https://img.shields.io/cocoapods/l/BrickRequest.svg?style=flat)](http://cocoapods.org/pods/BrickRequest)
[![Platform](https://img.shields.io/cocoapods/p/BrickRequest.svg?style=flat)](http://cocoapods.org/pods/BrickRequest)

<center>
<img src="icon.png">
</center>

- まだ開発段階なので、足りていない機能や、APIに変更があるかもしれません。

- BrickRequestはAlamofireのヘルパーライブラリです。
- Alamofireを利用しつつ、APIリクエストのコードの可読性をupし、共通のコードをまとめることが出来るようになります。
- BrickRequestではいくつかのプロトコルを用意しています。
protocol extensionを利用することで一つのリクエストをまるでLEGOブロックを組み立てるかのように簡単に定義・共通化が出来るようになります。
- クラスの定義を見るだけで、どのようなリクエストなのかを知ることも出来ます。
- Reachablityを利用した自動リトライ機能があります。


## Requirements

iOS8.0 +, Swift2.2

## Usage example

例えばユーザーを取得するAPIは以下のように組み立てることが出来ます。

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

GetUserクラスには多くのプロトコルが採用されていますが、
それぞれのプロトコルをBrickと例えて、以下のように定義しておきます。

GETリクエストを行うBrickを定義

```swift
protocol GETRequestType: RequestType {}

extension GETRequestType {
    var method: Alamofire.Method {
        return .GET
    }
}
```

リクエストを行うSessionを指定するBrickを定義

```swift
protocol APISessionRequestType: RequestType {}

extension APISessionRequestType {

    var session: Session {
        return SessionStack.APIBackgroundSession
    }
}
```

自動リトライは３回まで行うBrickを定義
```swift
protocol SoftAutoRetryType: RequestType {}

extension SoftAutoRetryType {
    var autoRetryConfiguration: Component.AutoRetryConfiguration {
        return Component.AutoRetryConfiguration(maxRetryCount: 3)
    }
}
```

レスポンスはSwiftyJSONのJSONに変換するBrickを定義
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

## Structure

- Sessionはリクエストを管理します。

```swift
public class Session {

    public init(manager: Alamofire.Manager, reachablityManager: Alamofire.NetworkReachabilityManager?)
```

- Componentはリクエストを作成するため (Component -> RequestContextにリネームするかも)

```swift
public class Component: Hashable {

}
```

リクエストを実行するためには
Componentクラスを継承し、以下の２つのプロトコルを実装する必要があります。

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

BrickRequest is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "BrickRequest"
```

## Author

muukii, m@muukii.me

## License

BrickRequest is available under the MIT license. See the LICENSE file for more info.
