//
//  ViewController.swift
//  AZLCoverView
//
//  Created by azusalee on 03/09/2022.
//  Copyright (c) 2022 azusalee. All rights reserved.
//

import UIKit
import AZLCoverView

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let button = UIButton.init(frame: CGRect.init(x: 50, y: 50, width: 100, height: 50))
        button.setTitle("点击我", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.addTarget(self, action: #selector(buttonDidTap(_:)), for: .touchUpInside)
        self.view.addSubview(button)
        
        let button2 = UIButton.init(frame: CGRect.init(x: 50, y: 200, width: 100, height: 50))
        button2.setTitle("点击我", for: .normal)
        button2.setTitleColor(UIColor.blue, for: .normal)
        button2.addTarget(self, action: #selector(buttonDidTap(_:)), for: .touchUpInside)
        self.view.addSubview(button2)
        
        
        let coverView = AZLCoverView.init(frame: UIScreen.main.bounds)
        coverView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        coverView.addHollow(frame: button.frame)
        
        coverView.addHollow(center: CGPoint.init(x: 200, y: 200), radius: 60)
        
        self.view.addSubview(coverView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc
    func buttonDidTap(_ sender: UIButton) {
        print("按钮点击了")
    }

}

