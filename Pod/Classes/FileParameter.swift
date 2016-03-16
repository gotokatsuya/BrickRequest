// FileParameter.swift 
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

public struct FileParameter {
    
    public var name: String {
        switch self.dataType {
        case .Data(_, let name, _, _):
            return name
        case .URL(_, let name, _, _):
            return name
        case .Stream(_, _, let name, _, _):
            return name
        }
    }
    
    public enum DataType {
        case Data(data: NSData?, name: String, fileName: String, mimeType: String)
        case URL(URL: NSURL, name: String, fileName: String, mimeType: String)
        case Stream(stream: NSInputStream, length: UInt64, name: String, fileName: String, mimeType: String)
    }
    
    public let dataType: DataType
    
    public init(_ data: NSData?, name: String, fileName: String, mimeType: String) {
        self.dataType = .Data(data: data?.copy() as? NSData, name: name, fileName: fileName, mimeType: mimeType)
    }
    
    public init(_ url: NSURL, name: String, fileName: String, mimeType: String) {
        self.dataType = .URL(URL: url, name: name, fileName: fileName, mimeType: mimeType)
    }
    
    public init(_ stream: NSInputStream, length: UInt64, name: String, fileName: String, mimeType: String) {
        self.dataType = .Stream(stream: stream, length: length, name: name, fileName: fileName, mimeType: mimeType)
    }
}
