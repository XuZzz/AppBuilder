//
//  Builder.swift
//  AppBuilder_Example
//
//  Created by 许朕 on 2021/4/6.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation

protocol AppBuilderNameSpace {
    associatedtype WrapperType
    var builder: WrapperType {get}
}

extension AppBuilderNameSpace {
    var builder: AppBuilderWrapper<Self> {
        return AppBuilderWrapper(self)
    }
}


public struct AppBuilderWrapper<Base> {
    public var base: Base
    public init(_ base: Base) {
        self.base = base
    }
}
