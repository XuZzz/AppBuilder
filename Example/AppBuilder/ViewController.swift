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
        customView.builder.addhere(at: view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

