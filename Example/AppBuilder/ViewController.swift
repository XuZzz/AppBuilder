//
//  ViewController.swift
//  AppBuilder
//
//  Created by 许朕 on 04/06/2021.
//  Copyright (c) 2021 许朕. All rights reserved.
//

import UIKit
import AppBuilder

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let customView = UIView()
        customView
            .builder
            .addhere(at: view)
            .layout{(make) in
                make.center.equalTo(view)
                make.size.equalTo(CGSize(width: 30, height: 30))
            }
            .config { (base) in
                base.backgroundColor = .red
            }
        
        UIButton()
            .builder
            .addhere(at: view)
            .layout { (make) in
                make.center.equalTo(view)
                make.size.equalTo(CGSize(width: 100, height: 100))
            }
            .normalTitle("Tapped me", color: .white)
            .selectedTitle("Success", color: .orange)
            .backgroundColor(.blue, state: .normal)
            .backgroundColor(.black, state: .selected)
            .addEvent(.touchUpInside) { (sender) in
                sender.isSelected.toggle()
            }
            
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

