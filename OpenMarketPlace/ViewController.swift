//
//  ViewController.swift
//  OpenMarketPlace
//
//  Created by Shangrong Li on 9/17/20.
//  Copyright © 2020 2OP. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        let reusableView = ReuseableExample.instantiateFromNib();
        self.view.addSubview(reusableView)
        
    }


}

