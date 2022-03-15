//
//  theorize.swift
//  People
//
//  Created by Ruben Mercado on 6/5/20.
//  Copyright © 2020 Sirius Awe. All rights reserved.
//

import UIKit

class theorize: UIView {

    @IBOutlet weak var quoteround: UIView!
    
    var centerxp:CGFloat = 0.0
    @IBOutlet weak var newquotebut: UIButton!
    @IBOutlet weak var textlabel: UILabel!
    let theoreos:[String] = ["You know you’re in love when you can’t fall asleep because reality is finally better than your dreams.- Dr. Suess","I’m selfish, impatient and a little insecure. I make mistakes, I am out of control and at times hard to handle. But if you can’t handle me at my worst, then you sure as hell don’t deserve me at my best.-Marilyn Monroe","Get busy living or get busy dying- stephen king","The Way Get Started Is To Quit Talking And Begin Doing. – Walt Disney","The Pessimist Sees Difficulty In Every Opportunity. The Optimist Sees Opportunity In Every Difficulty. – Winston Churchill","Don’t Let Yesterday Take Up Too Much Of Today. – Will Rogers","You Learn More From Failure Than From Success. Don’t Let It Stop You. Failure Builds Character. – Unknown","It’s Not Whether You Get Knocked Down, It’s Whether You Get Up. –  Vince Lombardi","If You Are Working On Something That You Really Care About, You Don’t Have To Be Pushed. The Vision Pulls You. – Steve Jobs","People Who Are Crazy Enough To Think They Can Change The World, Are The Ones Who Do. – Rob Siltanen","Failure Will Never Overtake Me If My Determination To Succeed Is Strong Enough. – Og Mandino","Knowing Is Not Enough; We Must Apply. Wishing Is Not Enough; We Must Do. – Johann Wolfgang Von Goethe","Creativity Is Intelligence Having Fun. – Albert Einstein","Light travels faster than sound. This is why some people appear bright until you hear them speak.- Alan Dundes","Be who you are and say what you feel, because those who mind don’t matter and those who matter don’t mind.- Bernard Baruch","Facebook just sounds like a drag, in my day seeing pictures of peoples vacations was considered a punishment.- Betty White","It does not matter how slowly you go as long as you do not stop. – Confucius","Success is not final, failure is not fatal: it is the courage to continue that counts. - Winston Churchill","Believe you can and you’re halfway there. – Theodore Roosevelt","Never bend your head. Always hold it high. Look the world straight in the eye. - Helen Keller","What you get by achieving your goals is not as important as what you become by achieving your goals. - Zig Ziglar","Sometimes you will never know the value of a moment, until it becomes a memory. - Dr. Suess","Be the change that you wish to see in the world. - Mahatma Ganndhi","If I cannot do great things, I can do small things in a great way. - Martin Luther King Jr. ","No matter what people tell you, words and ideas can change the world. - Robin Williams","If a man does not have the sauce, then he is lost. But the same man can be lost in the sauce. -Gucci Mane"]
    
   
    @IBAction func newquote(_ sender: UIButton) {
            
        self.textlabel.text = self.theoreos[Int.random(in: 0...self.theoreos.count - 1)]
           
        
        
        
    }
    func swipedd(){
       let swipe = UISwipeGestureRecognizer(target: self, action: #selector(theorize.centercontent(_:)))
    let swipel = UISwipeGestureRecognizer(target: self, action: #selector(theorize.centercontent(_:)))
    swipel.direction = .left
         self.addGestureRecognizer(swipe)
       self.addGestureRecognizer(swipel)
       }
    
    override func layoutSubviews() {
        self.textlabel.text = theoreos[Int(arc4random_uniform(UInt32(theoreos.count)))]
              self.centerxp = self.quoteround.center.x
              
        self.newquotebut.layer.cornerRadius = self.newquotebut.frame.height / 2
        self.newquotebut.layer.masksToBounds = true
        self.quoteround.layer.cornerRadius = self.newquotebut.frame.height / 2
        textlabel.textColor = Peeple.isARActive ? .white : .systemGray
        newquotebut.setTitleColor(Peeple.isARActive ? .white : .systemGray, for: .normal)
        self.quoteround.layer.masksToBounds = true
    }
    @objc func centercontent(_ sender: UISwipeGestureRecognizer) {
    if sender.direction == .right {
        UIView.animate(withDuration: 1.1,delay: 0 ,options: [.curveEaseIn], animations: {
            self.quoteround.center.x = self.center.x
            self.layoutIfNeeded()
        })
    } else if sender.direction == .left {
        UIView.animate(withDuration: 1.1,delay: 0 ,options: [.curveEaseOut], animations: {
                       self.quoteround.center.x = self.centerxp
                       self.layoutIfNeeded()
                   })
    }
    }
    
    
    class func instanceFromNib() -> UIView {
           return UINib(nibName: "theorize", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
          }
       
    

}
