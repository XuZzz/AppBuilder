//
//  UIButtonActionExtension.swift
//  AppBuilder
//
//  Created by 许朕 on 2021/4/6.
//

import Foundation

extension UIButton {
    
    private struct AssociatedKeys{
        static var actionKey = "actionKey"
        static var normalBackgroundColorKey = "normalBackgroundColorKey"
        static var selectedBackgroundColorKey = "selectedBackgroundColorKey"
    }
    
    @objc dynamic var action: ButtonAction? {
        set{
            objc_setAssociatedObject(self,&AssociatedKeys.actionKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        }
        get{
            if let action = objc_getAssociatedObject(self, &AssociatedKeys.actionKey) as? ButtonAction{
                return action
            }
            return nil
        }
    }
    
    @objc dynamic var normalBackgroundColor: UIColor? {
        set{
            objc_setAssociatedObject(self,&AssociatedKeys.normalBackgroundColorKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        }
        get{
            if let color = objc_getAssociatedObject(self, &AssociatedKeys.normalBackgroundColorKey) as? UIColor{
                return color
            }
            return backgroundColor
        }
    }
    
    @objc dynamic var selectedBackgroundColor: UIColor? {
        set{
            objc_setAssociatedObject(self,&AssociatedKeys.selectedBackgroundColorKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        }
        get{
            if let color = objc_getAssociatedObject(self, &AssociatedKeys.selectedBackgroundColorKey) as? UIColor{
                return color
            }
            return backgroundColor
        }
    }
    
    func addAction(_ action: @escaping ButtonAction, controlEvent: UIControl.Event) {
        self.action = action
        self.addTarget(self, action: #selector(touchUpInSideBtnAction), for: controlEvent)
    }
    
    @objc func touchUpInSideBtnAction(btn: UIButton) {
        if let action = self.action {
            action(btn)
        }
    }
    
    func setBackgroundColor(color: UIColor, state: UIControl.State) {
        setBackgroundImage(UIImage(color: color), for: state)
    }
    
    
}
