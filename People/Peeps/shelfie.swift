//
//  shelfiecontroller.swift
//  People
//
//  Created by Ruben Mercado on 6/27/20.
//  Copyright © 2020 Sirius Awe. All rights reserved.
//

import UIKit

class shelfiecontroller: UIView {

  
    @IBOutlet weak var bookview: UIView!
    
    
    var centerxp:CGFloat = 0.0
    
    @IBOutlet weak var movieview: UIView!
    
    func swipedd(){
       
       let swipe = UISwipeGestureRecognizer(target: self, action: #selector(shelfiecontroller.centercontent(_:)))
    
       
    let swipel = UISwipeGestureRecognizer(target: self, action: #selector(shelfiecontroller.centercontent(_:)))
    swipel.direction = .left
    swipel.cancelsTouchesInView = false
        self.addGestureRecognizer(swipe)
       self.addGestureRecognizer(swipel)
       
       
       
       }
    override func layoutSubviews() {
        swipedd()
        self.centerxp = self.bookview.center.x
        self.bookview.layer.cornerRadius = self.bookview.frame.height / 7
        self.bookview.layer.masksToBounds = true
         self.movieview.layer.cornerRadius = self.movieview.frame.height / 7
        self.movieview.layer.masksToBounds = true
        
        
    }
    @objc func centercontent(_ sender: UISwipeGestureRecognizer) {
    if sender.direction == .right {
                
        UIView.animate(withDuration: 1.1,delay: 0 ,options: [.curveEaseIn], animations: {
            self.bookview.center.x = self.center.x
            self.movieview.center.x = self.center.x
            self.layoutIfNeeded()
        })
    } else if sender.direction == .left {
        UIView.animate(withDuration: 1.1,delay: 0 ,options: [.curveEaseOut], animations: {
                       self.bookview.center.x = self.centerxp
                       self.movieview.center.x = self.centerxp
                       self.layoutIfNeeded()
                   })
    }
    }
    
    
    
    class func instanceFromNib() -> UIView {
       return UINib(nibName: "shelfie", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
      }
    
    
    
}
