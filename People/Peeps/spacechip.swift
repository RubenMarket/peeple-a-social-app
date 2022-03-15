//
//  spacechip.swift
//  People
//
//  Created by Ruben Mercado on 6/4/20.
//  Copyright © 2020 Sirius Awe. All rights reserved.
//

import Foundation
import UIKit
import ARKit
import SceneKit

class spacechip : UIView {
    
    
    @IBOutlet weak var spriteKitView: SKView!
    
    override func didMoveToSuperview() {
       
        
    }
    override func removeFromSuperview() {
        super.removeFromSuperview()
        
        
        
    }
    
    class func instanceFromNib() -> UIView {
     return UINib(nibName: "spacechip", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    }
    
    

