//
//  File.swift
//  AppBuilder
//
//  Created by 许朕 on 2021/4/7.
//

import Foundation
import SnapKit
import Combine


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
    public func config(_ config: (Base)-> Void)-> Self {
        config(base)
        return base.builder
    }
    
    @available(iOS 13.0, *)
    @discardableResult
    public func bind(_ config:(Base)-> Void)-> Self {
        config(base)
        return base.builder
    }
    
    @available(iOS 13.0, *)
    @discardableResult
    public func bind<T>(to value: Published<T>.Publisher,
                        completion: @escaping(Subscribers.Completion<Error>?,
                                              T?, Base)-> Void)-> AnyCancellable {
        let subscription = value.sink { (done) in
            switch done {
            case .finished:
                completion(.finished, nil, base)
            case .failure(let error):
                completion(.failure(error), nil, base)
            }
        } receiveValue: { (value) in
            completion(nil, value, base)
        }
        
        return subscription
    }
    
    @available(iOS 13.0, *)
    @discardableResult
    public func bind<T>(to value: Published<T>.Publisher,
                        completion: @escaping(T?, Base)-> Void)-> AnyCancellable {
        
        let subscription = value.sink { (value) in
            completion(value, base)
        }
        
        return subscription
    }
}
