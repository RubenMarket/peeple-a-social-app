//
//  awemember.swift
//  People
//
//  Created by Ruben Mercado on 6/25/20.
//  Copyright © 2020 Sirius Awe. All rights reserved.
//

import UIKit

class awemember: UIView {

    @IBOutlet weak var awememberlabel: UILabel!
    
    @IBOutlet weak var awememberimage: UIImageView!
    @IBOutlet weak var deslabel: UILabel!
    
    @IBOutlet weak var awememberbut: UIButton!
    
    @IBOutlet weak var centerawe: NSLayoutConstraint!
    var centerxp:CGFloat = 0.0
    @IBAction func awememberpessed(_ sender: Any) {
        
        
        
        
        
    }
    
    func swipedd(){
           
           let swipe = UISwipeGestureRecognizer(target: self, action: #selector(awemember.centercontent(_:)))
        
           self.addGestureRecognizer(swipe)
        let swipel = UISwipeGestureRecognizer(target: self, action: #selector(awemember.centercontent(_:)))
        swipel.direction = .left
        swipel.cancelsTouchesInView = false
           self.addGestureRecognizer(swipel)
           
           
           
           }
    override func layoutSubviews() {
        self.centerxp = self.awememberimage.center.x
        self.awememberbut.layer.cornerRadius = self.awememberbut.frame.height / 2
        self.awememberbut.layer.masksToBounds = true
        self.deslabel.layer.cornerRadius = self.awememberbut.frame.height / 2
        self.deslabel.layer.masksToBounds = true
        DispatchQueue.main.async {
        self.deslabel.text = "\(Person.ID)'s an Awe Member"
        }
        
        
        
    }
    @objc func centercontent(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .right {
                    
            UIView.animate(withDuration: 1.1,delay: 0 ,options: [.curveEaseIn], animations: {
                self.awememberbut.center.x = self.center.x
                self.awememberimage.center.x = self.center.x
                self.deslabel.center.x = self.center.x

                self.layoutIfNeeded()
            }) { (true) in
                
                
            }
        
        } else if sender.direction == .left {
            
            UIView.animate(withDuration: 1.1,delay: 0 ,options: [.curveEaseOut], animations: {
                           self.awememberbut.center.x = self.centerxp
                           self.awememberimage.center.x = self.centerxp
                           self.deslabel.center.x = self.centerxp

                           self.layoutIfNeeded()
                       }) { (true) in
                           
                           
                       }
            
            
            
            
        }
            
           
            
        }
    class func instanceFromNib() -> UIView {
     return UINib(nibName: "awemember", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    
}
