// TextParameter.swift 
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

public protocol TextParameterType {
    
    var name: String { get }
    var string: String? { get }
    var data: NSData? { get }
}

public class TextParameter<T: ParameterStringConvertible>: TextParameterType {
    
    public var data: NSData? {
        
        guard let wrappedValue = self.value else {
            return self._catchOnNilHandler?().parameterString.dataUsingEncoding(NSUTF8StringEncoding)
        }
        
        return wrappedValue.parameterString.dataUsingEncoding(NSUTF8StringEncoding)
    }
    
    public var string: String? {
        return self.value?.parameterString ?? self._catchOnNilHandler?().parameterString
    }
    
    public let name: String
    
    public let value: T?
    
    public func catchOnNil(closure: () -> T) -> TextParameter {
        
        self._catchOnNilHandler = closure
        return self
    }
    
    public init(value: T?, name: String) {
        self.value = value
        self.name = name
    }
    
    private var _catchOnNilHandler: (() -> T)?
}

extension String: ParameterStringConvertible {
    
    public var parameterString: String {
        return self
    }
}

extension Int: ParameterStringConvertible {
    
    public var parameterString: String {
        return String(self)
    }
}

extension Int8: ParameterStringConvertible {
    
    public var parameterString: String {
        return String(self)
    }
}

extension Int16: ParameterStringConvertible {
    
    public var parameterString: String {
        return String(self)
    }
}

extension Int32: ParameterStringConvertible {
    
    public var parameterString: String {
        return String(self)
    }
}

extension Int64: ParameterStringConvertible {
    
    public var parameterString: String {
        return String(self)
    }
}

extension UInt: ParameterStringConvertible {
    
    public var parameterString: String {
        return String(self)
    }
}

extension UInt8: ParameterStringConvertible {
    
    public var parameterString: String {
        return String(self)
    }
}

extension UInt16: ParameterStringConvertible {
    
    public var parameterString: String {
        return String(self)
    }
}

extension UInt32: ParameterStringConvertible {
    
    public var parameterString: String {
        return String(self)
    }
}

extension UInt64: ParameterStringConvertible {
    
    public var parameterString: String {
        return String(self)
    }
}

extension NSNumber: ParameterStringConvertible {
    
    public var parameterString: String {
        return self.stringValue
    }
}

extension Bool: ParameterStringConvertible {
    
    public var parameterString: String {
        return String(NSNumber(bool: self))
    }
}

extension Float: ParameterStringConvertible {
    
    public var parameterString: String {
        return String(self)
    }
}

extension Double: ParameterStringConvertible {
    
    public var parameterString: String {
        return String(self)
    }
}
