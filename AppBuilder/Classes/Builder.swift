//
//  Builder.swift
//  AppBuilder_Example
//
//  Created by 许朕 on 2021/4/6.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation

public protocol AppBuilderNameSpace {
    associatedtype WrapperType
    var builder: WrapperType {get}
}

extension AppBuilderNameSpace {
    public var builder: AppBuilderWrapper<Self> {
        return AppBuilderWrapper(self)
    }
}


public struct AppBuilderWrapper<Base> {
    public var base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

extension UIView: AppBuilderNameSpace {}

extension AppBuilderWrapper where Base: UIView {
    @discardableResult
    public func addhere(at superview: UIView)-> Self {
        superview.addSubview(base)
        return base.builder
    }
}

func helloBuilder() {
    print("Builder listening")
}
