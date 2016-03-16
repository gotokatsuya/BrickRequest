// Parameters.swift
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

public enum ParametersError: ErrorType {
    case MultipartFormDataParseError
    case ParameterParseError
}

public protocol ParameterStringConvertible {
    
    var parameterString: String { get }
}

public struct ParameterBuilder {
    
    public func createMultipartFormData() throws -> Alamofire.MultipartFormData {
        
        let multipart = MultipartFormData()
        
        for value in self.textParameters {
            guard let data = value.data else {
                throw ParametersError.MultipartFormDataParseError
            }
            multipart.appendBodyPart(data: data, name: value.name)
        }
        
        for value in self.fileParameters {
            switch value.dataType {
            case .Data(let data?, let name, let fileName, let mimeType):
                multipart.appendBodyPart(data: data, name: name, fileName: fileName, mimeType: mimeType)
            case .Stream(let stream, let length, let name, let fileName, let mimeType):
                multipart.appendBodyPart(stream: stream, length: length, name: name, fileName: fileName, mimeType: mimeType)
            case .URL(let URL, let name, let fileName, let mimeType):
                multipart.appendBodyPart(fileURL: URL, name: name, fileName: fileName, mimeType: mimeType)
            default:
                break
            }
        }
        
        return multipart
    }

    public func createParameter() throws -> [String : AnyObject] {
        
        var parameters: [String : AnyObject] = [ : ]
        
        for value in self.textParameters {
            
            parameters[value.name] = value.string
        }
        
        return parameters        
    }
    
    public init() {
        
    }
    
    public mutating func add(parameter: TextParameterType) {
    
        self.textParameters.append(parameter)            
    }
    
    public mutating func add(parameter: FileParameter) {
        
        self.fileParameters.append(parameter)
    }

    private var textParameters: [TextParameterType] = []
    private var fileParameters: [FileParameter] = []
}
