//
//  UIStackView+AppBuilder.swift
//  AppBuilder
//
//  Created by 许朕 on 2021/4/16.
//

import Foundation

public protocol SpaceView {}

extension SpaceView where Self: UIStackView {
    @discardableResult
    public func addSpace(id: String = "", value: CGFloat = 10)-> Self {
        let view = UIView(frame: .zero)
        self.addArrangedSubview(view)
        if self.axis == .vertical {
            view.snp.makeConstraints { (make) in
                make.height.equalTo(value)
            }
        }else {
            view.snp.makeConstraints { (make) in
                make.width.equalTo(value)
            }
        }
        return self
    }
}


public class VStackView: UIStackView, SpaceView {
    
    convenience init(distribution: Distribution = .fill, alignment: Alignment? = nil, spacing: CGFloat? = nil) {
        //
        self.init(frame: .zero)
        self.axis = .vertical
        self.distribution = distribution
        if let a = alignment {
            self.alignment = a
        }
        
        if let s = spacing {
            self.spacing = s
        }
    }
}

public class HStackView: UIStackView, SpaceView {
    
    convenience init(distribution: Distribution = .fill, alignment: Alignment? = nil, spacing: CGFloat? = nil) {
        //
        self.init(frame: .zero)
        self.axis = .horizontal
        self.distribution = distribution
        if let a = alignment {
            self.alignment = a
        }
        
        if let s = spacing {
            self.spacing = s
        }
    }
}

extension UIStackView {
    @discardableResult
    public func add(_ view: UIView, layout: ((UIView)->Void)? = nil )-> Self {
        self.addArrangedSubview(view)
        layout?(view)
        return self
    }
}



