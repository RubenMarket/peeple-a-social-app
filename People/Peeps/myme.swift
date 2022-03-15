//
//  mymecontroller.swift
//  People
//
//  Created by Ruben Mercado on 6/27/20.
//  Copyright © 2020 Sirius Awe. All rights reserved.
//

import UIKit

class mymecontroller: UIView {

    @IBOutlet weak var mymeview: UIImageView!
   
    private var mymes:[String] = ["",""]
    @IBOutlet weak var newmymebut: UIButton!
    private var centerxp:CGFloat = 0.0
    @IBAction func nyme(_ sender: UIButton) {
//        mymeview.image = UIImage(named:mymes[Int.random(in: 0...self.mymes.count)])
    }
    
    func swipedd(){
       let swipe = UISwipeGestureRecognizer(target: self, action: #selector(mymecontroller.centercontent(_:)))
    let swipel = UISwipeGestureRecognizer(target: self, action: #selector(mymecontroller.centercontent(_:)))
    swipel.direction = .left
         self.addGestureRecognizer(swipe)
       self.addGestureRecognizer(swipel)
       }
    
    
    override func layoutSubviews() {
        swipedd()
        self.centerxp = self.mymeview.center.x
        self.newmymebut.circle()
//        self.mymeview.image = UIImage(named:mymes[Int.random(in: 0...self.mymes.count)])
    }
    
    @objc func centercontent(_ sender: UISwipeGestureRecognizer) {
         if sender.direction == .right {
             UIView.animate(withDuration: 1.1,delay: 0 ,options: [.curveEaseIn], animations: {
                 self.mymeview.center.x = self.center.x
                 self.newmymebut.center.x = self.center.x
                 self.layoutIfNeeded()
             })
         } else if sender.direction == .left {
             UIView.animate(withDuration: 1.1,delay: 0 ,options: [.curveEaseOut], animations: {
                            self.mymeview.center.x = self.centerxp
                            self.newmymebut.center.x = self.centerxp
                            self.layoutIfNeeded()
                        })
         }
         }
     class func instanceFromNib() -> UIView {
      return UINib(nibName: "myme", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
     }
    
    
    
    
    
    
}
