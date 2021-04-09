//
//  ViewController.swift
//  AppBuilder
//
//  Created by 许朕 on 04/06/2021.
//  Copyright (c) 2021 许朕. All rights reserved.
//

import UIKit
import AppBuilder
import Combine
import Moya



class CustomViewModel {
    
    @Published var title = false
}

class ViewController: UIViewController {
    
    
    private var subscriptions = Set<AnyCancellable>()
    
    private var viewModel = CustomViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let customView = UIView()
        customView
            .builder
            .addhere(at: view)
            .layout{(make) in
                make.center.equalTo(view)
                make.size.equalTo(view.frame.size)
            }
            .config {(base) in
                base.backgroundColor = .red
            }
            .bind(to: viewModel.$title) { (value, base) in
                guard let value = value else {
                    return
                }
                if value {
                    base.backgroundColor = .black
                }else {
                    base.backgroundColor = .red
                }
            }
            .store(in: &subscriptions)
        
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
            .addEvent(.touchUpInside) { [weak self](sender) in
                sender.isSelected.toggle()
                self?.viewModel.title.toggle()
            }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

