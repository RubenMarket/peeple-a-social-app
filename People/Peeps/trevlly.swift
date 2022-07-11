//
//  Trevlly.swift
//  People
//
//  Created by admin on 7/8/22.
//  Copyright © 2022 A Sirius Company. All rights reserved.
//

import UIKit

class trevlly: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    class func instanceFromNib() -> UIView {
        
        return UINib(nibName: "Trevlly", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
}
