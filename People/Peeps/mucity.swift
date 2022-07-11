//
//  mucity.swift
//  People
//
//  Created by admin on 7/8/22.
//  Copyright © 2022 A Sirius Company. All rights reserved.
//

import UIKit

class mucity: UIView {

    class func instanceFromNib() -> UIView {
        return UINib(nibName: "Mucity", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView }

}
