//
//  clouds.swift
//  People
//
//  Created by admin on 7/8/22.
//  Copyright © 2022 A Sirius Company. All rights reserved.
//

import Foundation
import UIKit

class clouds: UIView {
    
    
    class func instanceFromNib() -> UIView {
        
        return UINib(nibName: "Clouds", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    override func layoutSubviews() {
        
    }
    
    
}
