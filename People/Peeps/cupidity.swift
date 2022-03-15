//
//  cupidity.swift
//  People
//
//  Created by Ruben Market on 8/26/21.
//  Copyright © 2021 A Sirius Company. All rights reserved.
//

import UIKit

class cupidity: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "Cupidity", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
       }
    
}
