//
//  ReuseableExample.swift
//  OpenMarketPlace
//
//  Created by Weifeng Li on 9/18/20.
//  Copyright © 2020 2OP. All rights reserved.
//

import UIKit

class ReuseableExample: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBOutlet weak var left: UIImageView!
    
    @IBAction func buttonCliked(_ sender: Any) {
        let myImage =  UIImage(named: "download-1");
        left.image = myImage;
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    class func instantiateFromNib() -> UIView {
        return UINib(nibName: "ReuseableExampleUIController", bundle: nil)
            .instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
}
