//
//  Builder.swift
//  AppBuilder_Example
//
//  Created by 许朕 on 2021/4/6.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import SnapKit

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


// --------------------------------------------------------
// UIView
// --------------------------------------------------------
extension AppBuilderWrapper where Base: UIView {
    @discardableResult
    public func addhere(at superview: UIView)-> Self {
        superview.addSubview(base)
        return base.builder
    }
    
    @discardableResult
    public func layout(_ snapKitMaker: (ConstraintMaker)-> Void)-> Self {
        base.snp.makeConstraints(snapKitMaker)
        return base.builder
    }
    
    @discardableResult
    public func config(_ c: (Base)-> Void)-> Self {
        c(base)
        return base.builder
    }
}

public typealias ButtonAction = (UIButton)-> Void
extension AppBuilderWrapper where Base: UIButton {
    @discardableResult
    public func addEvent(_ event: UIControl.Event, action: @escaping ButtonAction)-> Self {
        base.addAction(action, controlEvent: event)
        return base.builder
    }
    
    
    @discardableResult
    public func normalTitle(_ title: String, color: UIColor = .black)-> Self {
        base.setTitle(title, for: .normal)
        base.setTitleColor(color, for: .normal)
        return base.builder
    }
    
    @discardableResult
    public func selectedTitle(_ title: String, color: UIColor? = nil)-> Self {
        base.setTitle(title, for: .selected)
        base.setTitleColor(color == nil ? base.titleColor(for: .normal) : color!, for: .selected)
        return base.builder
    }
    
    
}
